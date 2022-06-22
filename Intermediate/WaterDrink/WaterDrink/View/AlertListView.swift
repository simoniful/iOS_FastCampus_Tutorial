//
//  MainView.swift
//  WaterDrink
//
//  Created by Sang hun Lee on 2022/05/14.
//

import Foundation
import UIKit
import SnapKit

class AlertListView: UIView, ViewRepresentable {
    let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
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
        self.backgroundColor = .systemBackground
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
