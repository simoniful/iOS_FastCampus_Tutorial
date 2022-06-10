//
//  CategoryListViewController.swift
//  Daangn
//
//  Created by Sang hun Lee on 2022/06/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CategoryListViewController: UIViewController {
    let disposeBag = DisposeBag()
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryListCell")
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: CategoryViewModel) {
        viewModel.cellData
            .drive(tableView.rx.items) { tableView, row, data in
                let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListCell", for: IndexPath(row: row, section: 0))
                cell.textLabel?.text = data.name

                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.pop
            .emit(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .map { $0.row }
            .bind(to: viewModel.itemSelected)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        view.backgroundColor = .systemBackground
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { 
            $0.edges.equalToSuperview()
        }
    }
}
