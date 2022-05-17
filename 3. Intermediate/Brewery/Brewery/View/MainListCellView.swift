//
//  MainListViewCell.swift
//  Brewery
//
//  Created by Sang hun Lee on 2022/05/17.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class MainListCellView: UITableViewCell {
    static let identifier = "MainListCellView"
    
    let beerImage = UIImageView()
    let nameLabel = UILabel()
    let tagLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImage, nameLabel, tagLabel].forEach {
            contentView.addSubview($0)
        }
        
        beerImage.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.numberOfLines = 2
        
        tagLabel.font = .systemFont(ofSize: 14, weight: .light)
        tagLabel.textColor = .systemBlue
        tagLabel.numberOfLines = 0
        
        beerImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImage.snp.trailing).offset(10)
            $0.bottom.equalTo(beerImage.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        tagLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
    }
    
    func configureCell(with beer: Beer) {
        let imageURL = URL(string: beer.imageURL ?? "")
        beerImage.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "beer_icon"))
        nameLabel.text = beer.name ?? "No named Beer"
        tagLabel.text = beer.tagline
        
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}
