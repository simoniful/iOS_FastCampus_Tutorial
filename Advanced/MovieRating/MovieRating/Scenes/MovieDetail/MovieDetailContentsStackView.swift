//
//  MovieDetailContentsStackView.swift
//  MovieRating
//
//  Created by Sang hun Lee on 2022/06/23.
//

import UIKit
import SnapKit

final class MovieDetailContentsStackView: UIStackView {
    private let title: String
    private let contents: String
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.text = title
        return label
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.text = contents
        label.numberOfLines = 0
        return label
    }()
    
    init(title: String, contents: String) {
        self.title = title
        self.contents = contents
        super.init(frame: .zero)
        
        axis = .horizontal
        
        [titleLabel, contentsLabel].forEach {
            addArrangedSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(80.0)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
