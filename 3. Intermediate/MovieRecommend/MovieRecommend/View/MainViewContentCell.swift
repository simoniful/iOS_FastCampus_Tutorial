//
//  MainViewContentCell.swift
//  MovieRecommend
//
//  Created by Sang hun Lee on 2022/05/16.
//

import Foundation
import SnapKit
import UIKit

class MainViewContentCell: UICollectionViewCell {
    static let identifier = "MainViewContentCell"
    
    let imageView = UIImageView()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
