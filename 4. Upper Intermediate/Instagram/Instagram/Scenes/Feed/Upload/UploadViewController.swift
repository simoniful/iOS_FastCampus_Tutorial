//
//  UploadViewController.swift
//  Instagram
//
//  Created by Sang hun Lee on 2022/05/30.
//

import UIKit

final class UploadViewController: UIViewController {
    // MARK: - Property
    private let uploadImage: UIImage
    let uploadView = UploadView()
    
    // MARK: - Initializing
    init(uploadImage: UIImage) {
        self.uploadImage = uploadImage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = uploadView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setNavigationBar()
        uploadView.imageView.image = uploadImage
    }
}

// MARK: - Navigation setup
private extension UploadViewController {
    func setNavigationBar() {
        navigationItem.title = "새 게시물"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(didTapLeftBarButton)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "공유",
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButton)
        )
    }
    
    @objc func didTapLeftBarButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapRightBarButton() {
        // 저장 로직 구현 후 dismiss
        dismiss(animated: true)
    }
}
