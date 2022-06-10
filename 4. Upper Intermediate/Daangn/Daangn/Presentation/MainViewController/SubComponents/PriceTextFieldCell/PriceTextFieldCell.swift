//
//  PriceTextFieldCell.swift
//  Daangn
//
//  Created by Sang hun Lee on 2022/06/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PriceTextFieldCell: UITableViewCell {
    let disposeBag = DisposeBag()
    
    static let identifier = "PriceTextFieldCell"
    
    let priceInputField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 17)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let freeShareButton: UIButton = {
        let button = UIButton()
        button.setTitle("무료나눔", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.tintColor = .orange
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.orange.cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10.0
        button.clipsToBounds = true
        button.isHidden = true
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: PriceTextFieldCellModel) {
        viewModel.showFreeShareButton
            .map { !$0 }
            .emit(to: freeShareButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.resetPrice
            .map { _ in "" }
            .emit(to: priceInputField.rx.text)
            .disposed(by: disposeBag)
        
        priceInputField.rx.text
            .bind(to: viewModel.priceText)
            .disposed(by: disposeBag)
        
        freeShareButton.rx.tap
            .bind(to: viewModel.freeShareButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        
    }
    
    private func layout() {
        [priceInputField, freeShareButton].forEach {
            contentView.addSubview($0)
        }
        
        priceInputField.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        
        freeShareButton.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(15)
            $0.width.equalTo(100)
        }
    }
}
