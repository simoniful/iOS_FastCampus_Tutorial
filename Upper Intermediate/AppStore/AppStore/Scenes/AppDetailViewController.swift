//
//  AppDetailViewController.swift
//  AppStore
//
//  Created by Sang hun Lee on 2022/05/23.
//

import UIKit
import SnapKit
import Kingfisher

final class AppDetailViewController: UIViewController, ViewRepresentable {
    private let today: Today
        
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.text = "Title"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.text = "Subtitle"
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("받기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        return button
    }()
    
    init(today: Today) {
        self.today = today
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // dark mode 활용 - systemBackground . label
        view.backgroundColor = .systemBackground
        setupView()
        setupConstraints()
        configureView()
    }
    
    func setupView() {
        [appIconImageView, titleLabel, subtitleLabel, downloadButton, shareButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        appIconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(32)
            $0.height.equalTo(100)
            $0.width.equalTo(appIconImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(appIconImageView.snp.top)
            $0.leading.equalTo(appIconImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        downloadButton.snp.makeConstraints {
            $0.bottom.equalTo(appIconImageView.snp.bottom)
            $0.height.equalTo(24)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.width.equalTo(60)
        }
        
        shareButton.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(shareButton.snp.width)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(downloadButton.snp.centerY)
        }
    }
    
    func configureView() {
        titleLabel.text = today.title
        subtitleLabel.text = today.subTitle
        if let imageURL = URL(string: today.imageURL) {
            appIconImageView.kf.setImage(with: imageURL)
        }
    }
    
    @objc func didTapShareButton() {
        // 공유하고자 하는 대상
        let activityItems: [Any] = [today.title, today.description]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}


