//
//  MainView.swift
//  SpotifyLogin
//
//  Created by Sang hun Lee on 2022/05/10.
//

import Foundation
import UIKit
import SnapKit

class MainView: UIView, ViewRepresentable {
    let welcomeLabel : UILabel = {
        let label = UILabel()
        label.text = "환영합니다"
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(UIColor.systemGray6, for: .normal)
        return button
    }()
    
    let passwordChangeButton: UIButton = {
        let button = UIButton()
        button.setTitle("비밀번호 변경", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(UIColor.systemGray6, for: .normal)
        return button
    }()
    
    let profileUpdateButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 업데이트", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(UIColor.systemGray6, for: .normal)
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
        addSubview(welcomeLabel)
        addSubview(passwordChangeButton)
        addSubview(profileUpdateButton)
        addSubview(logoutButton)
    }
    
    func setupConstraints() {
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.centerY.equalTo(safeAreaLayoutGuide)
        }
        
        passwordChangeButton.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(30)
            $0.bottom.equalTo(profileUpdateButton.snp.top).offset(-20)
        }
        
        profileUpdateButton.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.top.equalTo(passwordChangeButton.snp.bottom).offset(20)
            $0.bottom.equalTo(logoutButton.snp.top).offset(-20)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(profileUpdateButton.snp.bottom).offset(20)
            $0.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
}
