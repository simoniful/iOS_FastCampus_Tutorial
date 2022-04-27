//
//  PomoRxViewController.swift
//  Pomodoro
//
//  Created by Sang hun Lee on 2022/04/27.
//

import UIKit
import RxSwift
import RxCocoa
import AudioToolbox

class PomoRxViewController: UIViewController {
    var disposeBag = DisposeBag()
    private let pomoView = PomoView()
    private let pomoViewModel = PomoViewModel()
    
    fileprivate var isRunning: Bool = false
    
    var currentSeconds: Int = 0
    var duration = 60
    var timerStatus: TimerStatus = .end
    
    override func loadView() {
        self.view = pomoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configureToToggleButton()
        configureTimer()
        configureButtonsEvent()
    }
    
    func configureToToggleButton() {
        self.pomoView.toggleButton.setTitle("시작", for: .normal)
        self.pomoView.toggleButton.setTitle("일시정지", for: .selected)
    }
    
    func configureTimer() {
        let driver = Driver<Int>.interval(.seconds(1)).map { _ in
            return 1
        }
        driver.asObservable()
            .subscribe(onNext: { [weak self] value in
                if self!.isRunning {
                    guard let self = self else { return }
                    self.currentSeconds -= value
                    
                    self.pomoView.timerValueSetting(self.currentSeconds)
                    self.pomoView.progressView.progress = Float(self.currentSeconds) / Float(self.duration)
                    
                    UIView.animate(withDuration: 0.5, delay: 0) {
                        self.pomoView.pomodoroImage.transform = CGAffineTransform(rotationAngle: .pi)
                    }
                    UIView.animate(withDuration: 0.5, delay: 0.5) {
                        self.pomoView.pomodoroImage.transform = CGAffineTransform(rotationAngle: .pi * 2)
                    }
                    
                    if self.currentSeconds <= 0 {
                        self.isRunning = false
                        AudioServicesPlaySystemSound(1005)
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    func configureButtonsEvent() {
        pomoView.toggleButtonTapEvent { [weak self] (_) in
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
                self.isRunning = true
            // 일시정지 상태에서 재개할 때 버튼 플리커
            case .start:
                self.timerStatus = .pause
                self.pomoView.toggleButton.isSelected = false
                self.isRunning = false
            case .pause:
                self.timerStatus = .start
                self.pomoView.toggleButton.isSelected = true
                self.isRunning = true
            }
        }
        
        pomoView.cancelButtonTapEvent { [weak self] (_) in
            guard let self = self else { return }
            self.timerStatus = .end
            self.pomoView.cancelButton.isEnabled = false
            UIView.animate(withDuration: 0.5) {
                self.pomoView.timerLabel.alpha = 0
                self.pomoView.progressView.alpha = 0
                self.pomoView.datePicker.alpha = 1
                self.pomoView.transform = .identity
            }
            self.pomoView.toggleButton.isSelected = false
            self.isRunning = false
            self.currentSeconds = 0
            self.pomoView.timerValueSetting(self.currentSeconds)
        }
    }
}
