//
//  LoginView.swift
//  SpotifyLogin
//
//  Created by Sang hun Lee on 2022/05/09.
//

import Foundation
import UIKit
import SnapKit

class LoginView: UIView, ViewRepresentable {
    
    let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "music.house.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 마음에 꼭 드는 또 다른\n플레이리스트를\n발견해보세요."
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    let bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    let emailButton: UIButton = {
       let button = UIButton()
        button.setTitle("이메일/비밀번호로 계속하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 30
        return button
    }()
    
    let googleButton: UIButton = {
       let button = UIButton()
        button.setTitle("구글로 계속하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setImage(UIImage(named: "logo_google"), for: .normal)
        button.titleEdgeInsets.left = -31
        button.imageEdgeInsets.left = -119
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 30
        return button
    }()
    
    let appleButton: UIButton = {
       let button = UIButton()
        button.setTitle("애플로 계속하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setImage(UIImage(named: "logo_apple"), for: .normal)
        button.titleEdgeInsets.left = -31
        button.imageEdgeInsets.left = -119
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 30
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
        headerStackView.addArrangedSubview(logoImageView)
        headerStackView.addArrangedSubview(titleLabel)
        addSubview(headerStackView)
        bodyStackView.addArrangedSubview(emailButton)
        bodyStackView.addArrangedSubview(googleButton)
        bodyStackView.addArrangedSubview(appleButton)
        addSubview(bodyStackView)
    }
    
    func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.height.equalTo(70)
        }
        
        headerStackView.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.centerY.equalTo(safeAreaLayoutGuide).multipliedBy(0.8)
        }
        
        emailButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
        }
        
        googleButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
        }
        
        appleButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.leading.equalTo(0)
            $0.trailing.equalTo(0)
        }
        
        bodyStackView.snp.makeConstraints {
            $0.top.equalTo(headerStackView.snp.bottom).offset(60)
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(30)
            $0.trailing.equalTo(-30)
        }
    }
}
