//
//  TodayViewHeader.swift
//  AppStore
//
//  Created by Sang hun Lee on 2022/05/23.
//

import UIKit
import SnapKit

class TodayViewHeader: UICollectionReusableView, ViewRepresentable {
    
    static let identifier = "TodayViewHeader"
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = "5월 23일 월요일"
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 36, weight: .black)
        label.text = "투데이"
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        addSubview(dateLabel)
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
