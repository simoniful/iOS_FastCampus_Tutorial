//
//  ProfileDataView.swift
//  Instagram
//
//  Created by Sang hun Lee on 2022/05/28.
//

import UIKit
import SnapKit

final class ProfileDataView: UIView, ViewRepresentable {
    // MARK: - Property
    private let title: String
    private let count: Int
    
    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.text = title
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.text = "\(count)"
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countLabel, titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Initailizing
    init(title: String, count: Int) {
        self.title = title
        self.count = count
        super.init(frame: .zero)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI setup
    func setupView() {
        addSubview(labelStack)
    }
    
    func setupConstraints() {
        labelStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
