//
//  ViewController.swift
//  Pomodoro
//
//  Created by Sang hun Lee on 2022/04/26.
//

import UIKit
import RxSwift
import RxCocoa
import AudioToolbox

enum TimerStatus {
    case start
    case pause
    case end
}

class PomoViewController: UIViewController {
    var disposeBag = DisposeBag()
    private let pomoView = PomoView()
    private let pomoViewModel = PomoViewModel()
    
    var duration = 60
    var timerStatus: TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSeconds = 0
    
    override func loadView() {
        self.view = pomoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.configureToToggleButton()
        bind()
    }
    
    func configureToToggleButton() {
        self.pomoView.toggleButton.setTitle("시작", for: .normal)
        self.pomoView.toggleButton.setTitle("일시정지", for: .selected)
    }
    
    func startTimer() {
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                self.currentSeconds -= 1
                
                let hours = self.currentSeconds / 3600
                let minutes = self.currentSeconds % 3600 / 60
                let seconds = self.currentSeconds % 3600 % 60
                
                self.pomoView.timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
                self.pomoView.progressView.progress = Float(self.currentSeconds) / Float(self.duration)
                
                UIView.animate(withDuration: 0.5, delay: 0) {
                    // CGAffineTransform - 뷰의 프레임 계산 없이 2D 그래픽 그리는 것이 가능
                    self.pomoView.pomodoroImage.transform = CGAffineTransform(rotationAngle: .pi)
                }
                UIView.animate(withDuration: 0.5, delay: 0.5) {
                    self.pomoView.pomodoroImage.transform = CGAffineTransform(rotationAngle: .pi * 2)
                }
                
                if self.currentSeconds <= 0 {
                    self.stopTimer()
                    AudioServicesPlaySystemSound(1005)
                }
            })
            self.timer?.resume()
        }
    }
    
    func stopTimer() {
        if self.timerStatus == .pause {
            self.timer?.resume()
        }
        self.timerStatus = .end
        self.pomoView.cancelButton.isEnabled = false
        UIView.animate(withDuration: 0.5) {
            self.pomoView.timerLabel.alpha = 0
            self.pomoView.progressView.alpha = 0
            self.pomoView.datePicker.alpha = 1
            self.pomoView.transform = .identity
        }
        self.pomoView.toggleButton.isSelected = false
        self.timer?.cancel()
        self.timer = nil
    }

    func bind() {
        let input = PomoViewModel.Input(
            cancelButtonTap: pomoView.cancelButton.rx.tap,
            toggleButtonTap: pomoView.toggleButton.rx.tap)
        let output = pomoViewModel.transform(input: input)
        
        output.timerTrigger
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                self.duration = Int(self.pomoView.datePicker.countDownDuration)
                switch self.timerStatus {
                case .end:
                    self.currentSeconds = self.duration
                    self.timerStatus = .start
                    UIView.animate(withDuration: 0.5) {
                        self.pomoView.timerLabel.alpha = 1
                        self.pomoView.progressView.alpha = 1
                        self.pomoView.datePicker.alpha = 0
                    }
                    self.pomoView.toggleButton.isSelected = true
                    self.pomoView.cancelButton.isEnabled = true
                    self.startTimer()
                case .start:
                    self.timerStatus = .pause
                    self.pomoView.toggleButton.isSelected = false
                    self.timer?.suspend()
                case .pause:
                    self.timerStatus = .start
                    self.pomoView.toggleButton.isSelected = true
                    self.timer?.resume()
                }
            }
            .disposed(by: disposeBag)
        
        output.timerStop
            .subscribe { [weak self] (_) in
                guard let self = self else { return }
                switch self.timerStatus {
                case .start, .pause:
                    self.stopTimer()
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}

