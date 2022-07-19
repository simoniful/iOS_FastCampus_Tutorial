//
//  WriteViewController.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/19.
//

import UIKit
import SnapKit

final class WriteViewController: UIViewController {
    private lazy var presenter = WritePresenter(viewController: self)
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "닫기",
            style: .plain,
            target: self,
            action: #selector(didTapLeftBarButtonItem)
        )
        return barButtonItem
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "작성",
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButtonItem)
        )
        return barButtonItem
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "내용을 작성해주세요"
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 16.0, weight: .medium)
        textView.delegate = self
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

private extension WriteViewController {
    @objc func didTapLeftBarButtonItem() {
        presenter.didTapLeftBarButtonItem()
    }
    
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem(text: textView.text)
    }
}

extension WriteViewController: WriteProtocol {
    func setupNavigation() {
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(textView)
    }
    
    func setupConstraints() {
        let superViewInset: CGFloat = 16.0
        
        textView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(superViewInset)
            $0.leading.equalToSuperview().inset(superViewInset)
            $0.trailing.equalToSuperview().inset(superViewInset)
            $0.height.equalTo(160.0)
        }
    }

    func dismiss() {
        dismiss(animated: true)
    }
}

extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        textView.text = nil
        textView.textColor = .label
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard textView.textColor != .secondaryLabel else { return }
        rightBarButtonItem.isEnabled = !textView.text.isEmpty
    }
}
