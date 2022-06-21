//
//  ReviewListViewController.swift
//  BookReview
//
//  Created by Sang hun Lee on 2022/06/20.
//

import UIKit
import SnapKit

final class ReviewListViewController: UIViewController {
    // 초기화 되는 타이밍이 아닌, 프레젠터가 실질적으로 사용될 때 초기화가 되어 생성 될 수 있도록 lazy 키워드 사용
    private lazy var presenter = ReviewListPresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

// UI 인터렉션에 의해 특정한 기능을 수행하도록 하는 프로토콜 - 어디에 둘지 고민 필요
// extension ReviewListViewController: UITextViewDelegate {
//
// }

extension ReviewListViewController: ReviewListProtocol {
    func setupNavigationBar() {
        navigationItem.title = "도서 리뷰"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapRightBarButtonItem)
        )
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupViews() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func presentToReviewWriteViewController() {
        let reviewWriteViewController = UINavigationController(rootViewController: ReviewWriteViewController())
        reviewWriteViewController.modalPresentationStyle = .fullScreen
        present(reviewWriteViewController, animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
        print("최신 도서리뷰 목록 보여주기")
    }
}

private extension ReviewListViewController {
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}

