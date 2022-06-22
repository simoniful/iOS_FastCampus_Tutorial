//
//  SearchBookViewController.swift
//  BookReview
//
//  Created by Sang hun Lee on 2022/06/21.
//

import UIKit
import SnapKit

final class SearchBookViewController: UIViewController {
    private lazy var presenter = SearchBookPresenter(viewController: self, delegate: searchBookDelegate)
    
    private let searchBookDelegate: SearchBookDelegate
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = presenter
        tableView.dataSource = presenter
        tableView.register(SearchBookViewCell.self, forCellReuseIdentifier: SearchBookViewCell.identifier)
        return tableView
    }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    init(searchBookDelegate: SearchBookDelegate) {
        self.searchBookDelegate = searchBookDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchBookViewController: SearchBookProtocol {
    func setupView() {
        view.backgroundColor = .systemBackground
        
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        navigationItem.searchController = searchController
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func dismiss() {
        navigationItem.searchController?.dismiss(animated: true)
        dismiss(animated: true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
}
