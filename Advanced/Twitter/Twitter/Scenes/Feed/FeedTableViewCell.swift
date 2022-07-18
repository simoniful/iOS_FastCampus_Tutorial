//
//  FeedTableViewCell.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/18.
//

import UIKit
import SnapKit

final class FeedTableViewCell: UITableViewCell {
    static let identifier = "FeedTableViewCell"
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 21.0
        
        return imageView
    }()
    
    private lazy var writerNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        return label
    }()
    
    private lazy var writerAccountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(ButtonIcon.like.image, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(ButtonIcon.message.image, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(ButtonIcon.share.image, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [likeButton, commentButton, shareButton]
        )
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    func configureCell(tweet: Tweet) {
        selectionStyle = .none
        setupView()
        setupConstraints()
        
        writerNameLabel.text = tweet.user.name
        writerAccountLabel.text = "@\(tweet.user.account)"
        contentsLabel.text = tweet.contents
    }
}

private extension FeedTableViewCell {
    func setupView() {
        [
            profileImageView,
            writerNameLabel,
            writerAccountLabel,
            contentsLabel,
            buttonStackView
        ].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        let superviewMargin: CGFloat = 16.0
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(superviewMargin)
            $0.leading.equalToSuperview().inset(superviewMargin)
            $0.width.height.equalTo(40.0)
        }
        
        writerNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(superviewMargin)
        }
        
        writerAccountLabel.snp.makeConstraints {
            $0.leading.equalTo(writerNameLabel.snp.trailing).offset(2.0)
            $0.bottom.equalTo(writerNameLabel.snp.bottom)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(writerNameLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(writerNameLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(superviewMargin)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(contentsLabel.snp.bottom).offset(12.0)
            $0.leading.equalTo(writerNameLabel.snp.leading)
            $0.trailing.equalTo(contentsLabel.snp.trailing)
            $0.bottom.equalToSuperview().inset(superviewMargin)
        }
    }
}
