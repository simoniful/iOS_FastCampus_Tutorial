//
//  TitleTextFieldCell.swift
//  Daangn
//
//  Created by Sang hun Lee on 2022/06/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TitleTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    static let identifier = "TitleTextFieldCell"
    
    let titleInputField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: TitleTextFieldCellModel) {
        titleInputField.rx.text
            .bind(to: viewModel.titleText)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        titleInputField.font = .systemFont(ofSize: 17)
    }
    
    private func layout() {
        addSubview(titleInputField)
        
        titleInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
}
