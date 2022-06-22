//
//  HomeView.swift
//  Weather
//
//  Created by Sang hun Lee on 2022/04/29.
//

import Foundation
import UIKit
import SnapKit

class HomeView: UIView, ViewRepresentable {
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("날씨 가져오기", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.isHidden = true
        return stackView
    }()
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.text = "Seoul"
        return label
    }()
    
    let weatherStatusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "맑음"
        return label
    }()
    
    let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 3
        stackView.alignment = .center
        return stackView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .bold)
        label.text = "23°C"
        return label
    }()
    
    let subInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    let maxTemperLabel: UILabel = {
        let label = UILabel()
        label.text = "최고: 30°C"
        return label
    }()
    
    let minTemperLabel: UILabel = {
        let label = UILabel()
        label.text = "최저: 20°C"
        return label
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
        addSubview(searchTextField)
        addSubview(searchButton)
        headerStackView.addArrangedSubview(cityNameLabel)
        headerStackView.addArrangedSubview(weatherStatusLabel)
        subInfoStackView.addArrangedSubview(maxTemperLabel)
        subInfoStackView.addArrangedSubview(minTemperLabel)
        bodyStackView.addArrangedSubview(temperatureLabel)
        bodyStackView.addArrangedSubview(subInfoStackView)
        stackView.addArrangedSubview(headerStackView)
        stackView.addArrangedSubview(bodyStackView)
        addSubview(stackView)
    }
    
    func setupConstraints() {
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(30)
            $0.leading.equalTo(24)
            $0.trailing.equalTo(-24)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.centerX.equalTo(searchTextField.snp.centerX)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(searchButton.snp.bottom).offset(50)
            $0.leading.equalTo(24)
            $0.trailing.equalTo(-24)
        }
    }
}
