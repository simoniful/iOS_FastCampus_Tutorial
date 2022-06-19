//
//  BookmarkCell.swift
//  Translator
//
//  Created by Sang hun Lee on 2022/06/19.
//

import UIKit
import SnapKit

final class BookmarkCell: UICollectionViewCell {
    static let identifier = "BookmarkCell"
    
    private var sourceBookmarkTextStackView: BookmarkCellTextStack!
    private var targetBookmarkTextStackView: BookmarkCellTextStack!
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0
        stackView.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    func setupLayout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.size.width - 32.0)
        }
        
        layoutIfNeeded()
    }
    
    func configureCell(from bookmark: Bookmark) {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
        
        sourceBookmarkTextStackView = BookmarkCellTextStack(
            language: bookmark.sourceLanguage,
            text: bookmark.sourceText,
            type: .source
        )
        
        targetBookmarkTextStackView = BookmarkCellTextStack(
            language: bookmark.translatedLanguage,
            text: bookmark.translatedText,
            type: .target
        )
        
        // reuse 관련 꼬임 방지
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        [sourceBookmarkTextStackView, targetBookmarkTextStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        setupLayout()
    }
}
