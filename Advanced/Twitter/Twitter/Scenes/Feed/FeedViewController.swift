//
//  FeedViewController.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/18.
//

import UIKit
import Floaty
import SnapKit

final class FeedViewController: UIViewController {
    private lazy var presenter = FeedPresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.delegate = presenter
        tableView.register(
            FeedTableViewCell.self,
            forCellReuseIdentifier: FeedTableViewCell.identifier
        )
        return tableView
    }()
    
    private lazy var writeButton: Floaty = {
        let floaty = Floaty(size: 50.0)
        floaty.sticky = true
        floaty.handleFirstItemDirectly = true
        floaty.addItem(title: "") { _ in
            print("Floaty!")
        }
        floaty.buttonImage = ButtonIcon.write.image?.withTintColor(
            .white,
            renderingMode: .alwaysOriginal
        )
        return floaty
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension FeedViewController: FeedProtocol {
    func setupView() {
        navigationItem.title = "Feed"
        
        [tableView, writeButton].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        writeButton.paddingY = 100.0
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}
