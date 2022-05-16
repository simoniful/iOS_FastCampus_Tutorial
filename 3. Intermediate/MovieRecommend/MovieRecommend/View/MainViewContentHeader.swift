//
//  MainViewContentHeader.swift
//  MovieRecommend
//
//  Created by Sang hun Lee on 2022/05/16.
//

import Foundation
import UIKit

class MainViewContentHeader: UICollectionReusableView {
    static let identifier = "MainViewContentHeader"
    let sectionNameLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sectionNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        sectionNameLabel.textColor = .white
        sectionNameLabel.sizeToFit()
        
        addSubview(sectionNameLabel)
        sectionNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.leading.equalToSuperview().offset(10)
            
        }
    }
}
