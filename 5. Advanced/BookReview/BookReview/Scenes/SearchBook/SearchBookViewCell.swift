//
//  SearchBookViewCell.swift
//  BookReview
//
//  Created by Sang hun Lee on 2022/06/21.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchBookViewCell: UITableViewCell {
    static let identifier = "SearchBookViewCell"
    
    private lazy var bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 17.0, weight: .bold)
        label.text = "책 제목"
        return label
    }()
    
    private let bookAuthorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.text = "책 저자"
        return label
    }()
    
    private let bookPublisherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 11.0, weight: .medium)
        label.text = "출판사"
        return label
    }()
    
    private let bookDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 9.0, weight: .light)
        label.text = "책 관련 설명"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        [bookImageView, bookTitleLabel, bookAuthorLabel, bookPublisherLabel, bookDescriptionLabel].forEach {
            contentView.addSubview($0)
        }
        
        bookImageView.snp.makeConstraints {
            $0.width.height.equalTo(90.0)
            $0.top.equalToSuperview().offset(16.0)
            $0.leading.equalToSuperview().offset(16.0)
        }
        
        bookTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16.0)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        bookAuthorLabel.snp.makeConstraints {
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        bookPublisherLabel.snp.makeConstraints {
            $0.top.equalTo(bookAuthorLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        bookDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(bookPublisherLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(bookImageView.snp.trailing).offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
    
    func configureCell(_ bookData: Book) {
        bookTitleLabel.text = bookData.title.htmlEscaped
        bookImageView.kf.setImage(with: bookData.imageURL)
        bookAuthorLabel.text = bookData.author.htmlEscaped
        bookPublisherLabel.text = bookData.publisher.htmlEscaped
        bookDescriptionLabel.text = bookData.description == "" ?
        "책에 대한 상세 설명이 기재되지 않았습니다. \n추가적인 정보를 얻으시려면 문의 바랍니다." : bookData.description.htmlEscaped
    }
}
