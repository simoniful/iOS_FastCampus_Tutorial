//
//  DetailWriteFormCell.swift
//  Daangn
//
//  Created by Sang hun Lee on 2022/06/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class DetailWriteFormCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    static let identifier = "DetailWriteFormCell"
    
    let contentInputView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 17)
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: DetailWriteFormCellModel) {
        contentInputView.rx.text
            .bind(to: viewModel.detailContentText)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        addSubview(contentInputView)
        
        contentInputView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(300)
        }
    }
}
