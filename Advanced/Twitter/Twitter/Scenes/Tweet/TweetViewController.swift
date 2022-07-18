//
//  TweetViewController.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/18.
//

import UIKit

final class TweetViewController: UIViewController {
    private var presenter: TweetPresenter!
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 30.0
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        return label
    }()
    
    private lazy var userAccountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .bold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [userNameLabel, userAccountLabel]
        )
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4.0
        return stackView
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(ButtonIcon.like.image, for: .normal)
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
            arrangedSubviews: [likeButton, shareButton]
        )
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init(tweet: Tweet) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = TweetPresenter(viewController: self, tweet: tweet)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension TweetViewController: TweetProtocol {
    func setupView() {
        view.backgroundColor = .systemBackground
        
        [
            profileImageView,
            userInfoStackView,
            contentsLabel,
            buttonStackView
        ].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        let superviewMargin: CGFloat = 16.0
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(superviewMargin)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(superviewMargin)
            $0.width.height.equalTo(60.0)
        }
        
        userInfoStackView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8.0)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(superviewMargin)
            $0.centerY.equalTo(profileImageView.snp.centerY)
        }
        
        contentsLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(8.0)
            $0.leading.equalTo(profileImageView.snp.leading)
            $0.trailing.equalTo(userInfoStackView.snp.trailing)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(contentsLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(profileImageView.snp.leading)
            $0.trailing.equalTo(userInfoStackView.snp.trailing)
        }
    }
    
    func configureView(tweet: Tweet) {
        userNameLabel.text = tweet.user.name
        userAccountLabel.text = tweet.user.account
        contentsLabel.text = tweet.contents
    }
}
