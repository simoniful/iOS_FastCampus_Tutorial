//
//  RankingSectionViewCell.swift
//  AppStore
//
//  Created by Sang hun Lee on 2022/05/24.
//

import UIKit
import SnapKit

final class RankingSectionViewCell: UICollectionViewCell, ViewRepresentable {
    static let identifier = "RankingSectionViewCell"
    static var height: CGFloat { 70.0 }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemGroupedBackground
        imageView.layer.borderColor = UIColor.tertiaryLabel.cgColor
        imageView.layer.borderWidth = 0.5
        imageView.layer.cornerRadius = 7.0
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        label.text = "앱 이름"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.textColor = .secondaryLabel
        label.text = "앱 설명"
        return label
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13.0, weight: .bold)
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    private var inAppPurchaseInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "앱 내 구입"
        label.font = .systemFont(ofSize: 10.0, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        [imageView, titleLabel, descriptionLabel, downloadButton, inAppPurchaseInfoLabel].forEach {
            addSubview($0)
        }
        inAppPurchaseInfoLabel.isHidden = [true, false].randomElement() ?? true
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(4)
            $0.width.equalTo(imageView.snp.height)
        }
        
        downloadButton.snp.makeConstraints {
            $0.centerY.trailing.equalToSuperview()
            $0.height.equalTo(24)
            $0.width.equalTo(50)
        }
        
        inAppPurchaseInfoLabel.snp.makeConstraints {
            $0.centerX.equalTo(downloadButton.snp.centerX)
            $0.top.equalTo(downloadButton.snp.bottom).offset(4)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(8)
            $0.trailing.equalTo(downloadButton.snp.leading)
            $0.top.equalTo(imageView.snp.top).inset(8)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
}

