//
//  SearchView.swift
//  Subway
//
//  Created by Sang hun Lee on 2022/05/27.
//

import UIKit
import SnapKit

class SearchView: UIView, ViewRepresentable {
    lazy var resultTableView : UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError()
    }
    
    func setupView() {
        addSubview(resultTableView)
    }
    
    func setupConstraints() {
        resultTableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}




