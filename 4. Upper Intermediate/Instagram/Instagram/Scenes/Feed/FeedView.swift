//
//  FeedView.swift
//  Instagram
//
//  Created by Sang hun Lee on 2022/05/28.
//

import UIKit
import SnapKit

class FeedView: UIView, ViewRepresentable {
    // MARK: - UI Components
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.register(FeedViewCell.self, forCellReuseIdentifier: FeedViewCell.identifier)
        return tableView
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
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
