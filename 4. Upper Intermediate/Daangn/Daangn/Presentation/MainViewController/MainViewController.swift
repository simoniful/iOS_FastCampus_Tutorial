//
//  MainViewController.swift
//  Daangn
//
//  Created by Sang hun Lee on 2022/06/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        tableView.register(TitleTextFieldCell.self, forCellReuseIdentifier: TitleTextFieldCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategorySelectCell")
        tableView.register(PriceTextFieldCell.self, forCellReuseIdentifier: PriceTextFieldCell.identifier)
        tableView.register(DetailWriteFormCell.self, forCellReuseIdentifier: DetailWriteFormCell.identifier)
        return tableView
    }()
    
    let submitButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "제출"
        barButtonItem.style = .done
        return barButtonItem
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func bind(_ viewModel: MainViewModel) {
        
    }
    
    private func attribute() {
        title = "중고거래 글쓰기"
        view.backgroundColor = .white
        navigationItem.setRightBarButton(submitButton, animated: true)
        
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

typealias Alert = (title: String, message: String?)

extension Reactive where Base: MainViewController {
    var setAlert: Binder<Alert> {
        return Binder(base) { base, data in
            let alertController = UIAlertController(
                title: data.title,
                message: data.message,
                preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(action)
            base.present(alertController, animated: true, completion: nil)
        }
    }
    
}


