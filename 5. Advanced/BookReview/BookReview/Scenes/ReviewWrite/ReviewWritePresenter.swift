//
//  ReviewWritePresenter.swift
//  BookReview
//
//  Created by Sang hun Lee on 2022/06/20.
//

import UIKit

protocol ReviewWriteProtocol {
    func setupNavigationBar()
    func showCloseAlertController()
    func close()
    func setupView()
}

final class ReviewWritePresenter: NSObject {
    private let viewController: ReviewWriteProtocol
    
    init(viewController: ReviewWriteProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupView()
    }
    
    func didTapLeftBarButton() {
        viewController.showCloseAlertController()
    }
    
    func didTapRightBarButton() {
        // TODO: UserDefaults에 유저가 작성한 도시 리뷰를 저장하기
        viewController.close()
    }
}
