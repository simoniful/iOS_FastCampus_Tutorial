//
//  ResultList.swift
//  BlogCafeSearch
//
//  Created by Sang hun Lee on 2022/06/06.
//

import UIKit
import RxSwift
import RxCocoa

class ResultList: UITableView {
    let disposeBag = DisposeBag()
    
    let headerView = FilterView(
        frame: CGRect(
            origin: .zero,
            size: CGSize(width: UIScreen.main.bounds.width, height: 50)
        )
    )
    
    // MainViewController -> ResultList 데이터 전달
    let cellData = PublishSubject<[ResultListCellData]>()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        bind()
        attribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        cellData
            .asDriver(onErrorJustReturn: [])
            .drive(self.rx.items) { tableView, row, data in
                let index = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultListCell.identifier, for: index) as? ResultListCell else { return UITableViewCell() }
                cell.setData(data)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        self.backgroundColor = .white
        self.register(ResultListCell.self, forCellReuseIdentifier: ResultListCell.identifier)
        self.separatorStyle = .singleLine
        self.rowHeight = 100
        self.tableHeaderView = headerView
    }
}
