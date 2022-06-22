//
//  SeperatorView.swift
//  AppStore
//
//  Created by Sang hun Lee on 2022/05/24.
//

import UIKit
import SnapKit

final class SeperatorView: UIView, ViewRepresentable {
    
    
    private lazy var seperator: UIView = {
        let seperator = UIView()
        seperator.backgroundColor = .separator
        return seperator
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
        addSubview(seperator)
    }
    
    func setupConstraints() {
        seperator.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.top.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }
}
