//
//  View.swift
//  Pomodoro
//
//  Created by Sang hun Lee on 2022/04/26.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxRelay

class PomoView: UIView, ViewRepresentable {
    fileprivate let disposeBag = DisposeBag()
    
    let pomodoroImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pomodoro")
        return imageView
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progress = 1
        progressView.alpha = 0
        return progressView
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .countDownTimer
        return datePicker
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 80
        return stackView
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.isEnabled = true
        
        return button
    }()
    
    let toggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    func setupView() {
        self.backgroundColor = .systemBackground
        addSubview(pomodoroImage)
        addSubview(timerLabel)
        addSubview(progressView)
        addSubview(datePicker)
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(toggleButton)
        addSubview(stackView)
    }
    
    func setupConstraints() {
        pomodoroImage.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(24)
            $0.width.equalTo(100)
            $0.height.equalTo(100)
            $0.centerX.equalToSuperview()
        }
        
        timerLabel.snp.makeConstraints {
            $0.top.equalTo(pomodoroImage.snp.bottom).offset(80)
            $0.leading.equalTo(24)
            $0.trailing.equalTo(-24)
            $0.centerX.equalTo(pomodoroImage.snp.centerX)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(timerLabel.snp.bottom).offset(30)
            $0.leading.equalTo(48)
            $0.trailing.equalTo(-48)
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(pomodoroImage.snp.bottom).offset(30)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(datePicker.snp.bottom).offset(24)
            $0.leading.equalTo(24)
            $0.trailing.equalTo(-24)
        }
    }
}

/// rx 작업을 위한 extension
///
extension PomoView {
    func timerValueSetting(_ value: Int) {
        let hours = value / 3600
        let minutes = value % 3600 / 60
        let seconds = value % 3600 % 60
        
        timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func toggleButtonTapEvent(isTap: ((Bool) -> Void)?) {
        toggleButton.rx.tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe { _ in
                isTap?(true)
        }.disposed(by: disposeBag)
    }
    
    func cancelButtonTapEvent(isTap: ((Bool) -> Void)?) {
        cancelButton.rx.tap
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe { _ in
                isTap?(true)
        }.disposed(by: disposeBag)
    }
}
