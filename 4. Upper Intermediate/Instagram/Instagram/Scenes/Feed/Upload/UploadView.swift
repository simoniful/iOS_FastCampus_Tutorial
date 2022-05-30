//
//  UploadView.swift
//  Instagram
//
//  Created by Sang hun Lee on 2022/05/30.
//

import UIKit
import SnapKit

final class UploadView: UIView, ViewRepresentable {
    // MARK: - UI Components
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "문구 입력..."
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 15.0)
        textView.delegate = self
        return textView
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
        [imageView, textView].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
        // Double, CGFloat or Int, UInt 인지 타입 명시
        let imageViewInset: CGFloat = 16.0
        imageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(imageViewInset)
            $0.leading.equalToSuperview().inset(imageViewInset)
            $0.width.equalTo(100.0)
            $0.height.equalTo(imageView.snp.width)
        }
        
        textView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().inset(imageViewInset)
            $0.top.equalTo(imageView.snp.top)
            $0.bottom.equalTo(imageView.snp.bottom)
        }
    }
}

// MARK: - UITextViewDelegate
extension UploadView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        textView.text = nil
        textView.textColor = .label
    }
}
