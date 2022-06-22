//
//  MainViewContentRankCell.swift
//  MovieRecommend
//
//  Created by Sang hun Lee on 2022/05/16.
//

import Foundation
import UIKit

class MainViewContentRankCell: UICollectionViewCell {
    static let identifier = "MainViewContentRankCell"
    let imageView = UIImageView()
    let rankLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        rankLabel.font = .systemFont(ofSize: 100, weight: .black)
        rankLabel.textColor = .white
        contentView.addSubview(rankLabel)
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().offset(25)
        }
    }
}
