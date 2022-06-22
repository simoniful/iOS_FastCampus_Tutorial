//
//  ExchangeCodeSectionView.swift
//  AppStore
//
//  Created by Sang hun Lee on 2022/05/24.
//

import UIKit
import SnapKit

final class ExchangeCodeSectionView: UIView, ViewRepresentable {
    
    private lazy var exchangeButton: UIButton = {
        let button = UIButton()
        button.setTitle("코드 교환", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        
        button.backgroundColor = .tertiarySystemGroupedBackground
        button.layer.cornerRadius = 7.0
        
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
        addSubview(exchangeButton)
    }
    
    func setupConstraints() {
        exchangeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(40)
        }
    }
}
