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
        addSubview(logoutButton)
    }
    
    func setupConstraints() {
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.centerY.equalTo(safeAreaLayoutGuide)
        }
        
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            $0.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
}
