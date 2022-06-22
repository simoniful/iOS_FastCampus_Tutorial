//
//  RepositoryListViewCell.swift
//  
//
//  Created by Sang hun Lee on 2022/06/04.
//

import UIKit
import SnapKit

final class RepositoryListViewCell: UITableViewCell, ViewRepresentable {
    
    // MARK: - Property
    static let identifier = "RepositoryListViewCell"
    var repository: Repository?
    
    // MARK: - UI Components
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        return imageView
    }()
    
    let starLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    // MARK: - Initializing
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        setupConstraints()
        
        guard let repository = repository else { return }
        nameLabel.text = repository.name
        descriptionLabel.text = repository.description
        starLabel.text = "\(repository.stargazersCount)"
        languageLabel.text = repository.language
    }
    
    // MARK: - UI setup
    func setupView() {
        [nameLabel, descriptionLabel, starImageView, starLabel, languageLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(18)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(3)
            $0.leading.trailing.equalTo(nameLabel)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.equalTo(descriptionLabel)
            $0.width.height.equalTo(20)
            $0.bottom.equalToSuperview().inset(18)
        }
        
        starLabel.snp.makeConstraints {
            $0.centerY.equalTo(starImageView)
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
        }
        
        languageLabel.snp.makeConstraints {
            $0.centerY.equalTo(starLabel)
            $0.leading.equalTo(starLabel.snp.trailing).offset(12)
        }
    }
}
