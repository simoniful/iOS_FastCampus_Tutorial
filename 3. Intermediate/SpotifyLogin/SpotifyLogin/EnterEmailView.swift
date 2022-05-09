//
//  EnterEmailView.swift
//  SpotifyLogin
//
//  Created by Sang hun Lee on 2022/05/09.
//

import Foundation
import UIKit
import SnapKit

class EnterEmailView: UIView, ViewRepresentable {

    let inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 주소가 무엇인가요?"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .emailAddress
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호를 입력해주세요"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        return textField
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .systemRed
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.layer.cornerRadius = 30
        button.isEnabled = false
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
        self.backgroundColor = .black
        inputStackView.addArrangedSubview(emailLabel)
        inputStackView.addArrangedSubview(emailTextField)
        inputStackView.addArrangedSubview(passwordLabel)
        inputStackView.addArrangedSubview(passwordTextField)
        inputStackView.addArrangedSubview(errorLabel)
        addSubview(inputStackView)
        addSubview(nextButton)
    }
    
    func setupConstraints() {
        emailTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        inputStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(70)
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(30)
            $0.trailing.equalTo(-30)
        }
        
        nextButton.snp.makeConstraints {
            $0.top.equalTo(inputStackView.snp.bottom).offset(60)
            $0.width.equalTo(100)
            $0.height.equalTo(60)
            $0.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
}
