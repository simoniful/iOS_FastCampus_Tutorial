//
//  TodayViewCell.swift
//  AppStore
//
//  Created by Sang hun Lee on 2022/05/23.
//

import Foundation
import UIKit

class TodayViewCell: UICollectionViewCell, ViewRepresentable {
    
    static let identifier = "TodayViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.text = "제목"
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.text = "부제목"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.text = "소제목"
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        contentView.backgroundColor = .gray
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        
        [imageView, subtitleLabel, titleLabel, descriptionLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(24)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(24)
        }
    }
    
    func configureCell() {
        
    }
}
