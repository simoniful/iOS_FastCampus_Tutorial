//
//  ProfileViewCell.swift
//  Instagram
//
//  Created by Sang hun Lee on 2022/05/29.
//

import UIKit
import SnapKit

final class ProfileViewCell: UICollectionViewCell, ViewRepresentable {
    static let identifier = "ProfileViewCell"
    
    // MARK: - UI Components
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiaryLabel
        return imageView
    }()
    
    // MARK: - Initailizing
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI setup
    func setupView() {
        addSubview(imageView)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureCell(image: UIImage) {
        imageView.image = image
    }
}
