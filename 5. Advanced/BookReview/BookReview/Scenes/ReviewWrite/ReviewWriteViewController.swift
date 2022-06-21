//
//  ReviewWriteViewController.swift
//  BookReview
//
//  Created by Sang hun Lee on 2022/06/20.
//

import UIKit
import SnapKit
import Kingfisher

final class ReviewWriteViewController: UIViewController {
    private lazy var presenter = ReviewWritePresenter(viewController: self)
    
    private lazy var bookTitleButton: UIButton = {
        let button = UIButton()
        button.setTitle("책 제목", for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 23.0, weight: .bold)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapBookTitleButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .tertiaryLabel
        textView.text = presenter.contentTextViewPlaceHolderText
        textView.font = .systemFont(ofSize: 16.0, weight: .medium)
        textView.delegate = self
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ReviewWriteViewController: ReviewWriteProtocol {
    func setupNavigationBar() {
        let leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapLeftBarButton)
        )
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(didTapRightBarButton)
        )
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func showCloseAlertController() {
        let alertController = UIAlertController(title: "작성중인 내용이 있습니다. 정말 닫으시겠습니까?", message: nil, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "닫기", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        
        [cancelAction, closeAction].forEach {
            alertController.addAction($0)
        }
        present(alertController, animated: true)
    }
    
    func close() {
        self.dismiss(animated: true)
    }
    
    func presentToSearchBookViewController() {
        let searchBookViewController = UINavigationController(rootViewController: SearchBookViewController(searchBookDelegate: presenter))
        present(searchBookViewController, animated: true)
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        
        [bookTitleButton, contentTextView, imageView].forEach {
            view.addSubview($0)
        }
        
        bookTitleButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(bookTitleButton.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(16.0)
            $0.leading.trailing.equalTo(contentTextView)
            $0.height.equalTo(200.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func updateView(_ book: Book) {
        bookTitleButton.setTitle(book.title.htmlEscaped, for: .normal)
        bookTitleButton.setTitleColor(.label, for: .normal)
        imageView.kf.setImage(with: book.imageURL)
    }
}

extension ReviewWriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .label
    }
}

private extension ReviewWriteViewController {
    @objc func didTapLeftBarButton() {
        presenter.didTapLeftBarButton()
    }
    
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton(contentsText: contentTextView.text)
    }
    
    @objc func didTapBookTitleButton() {
        presenter.didTapBookTitleButton()
    }
}
