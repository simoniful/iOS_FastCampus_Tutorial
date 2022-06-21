//
//  ReviewListPresenter.swift
//  BookReview
//
//  Created by Sang hun Lee on 2022/06/20.
//

import UIKit
import Kingfisher

protocol ReviewListProtocol {
    func setupNavigationBar()
    func setupViews()
    func presentToReviewWriteViewController()
    func reloadTableView()
}

final class ReviewListPresenter: NSObject {
    private let viewController: ReviewListProtocol
    private let userDefaultManager = UserDefaultsManager()
    
    private var bookReviews: [BookReview] = []
    
    init(viewController: ReviewListProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController.setupNavigationBar()
        viewController.setupViews()
    }
    
    func viewWillAppear() {
        bookReviews = userDefaultManager.getReview()
        viewController.reloadTableView()
    }
    
    func didTapRightBarButtonItem() {
        viewController.presentToReviewWriteViewController()
    }
}

// 특정한 데이터를 리턴 - 뷰와 관계 없기에 Presenter에 구현
extension ReviewListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let review = bookReviews[indexPath.row]
        cell.textLabel?.text = review.title.htmlEscaped
        cell.detailTextLabel?.text = review.contents
        cell.imageView?.kf.setImage(with: review.imageURL, placeholder: .none, completionHandler: { _ in
            // 한 번 더 레이아웃 구성 업데이트
            cell.setNeedsLayout()
        })
        
        cell.selectionStyle = .none
        
        return cell
    }
}

