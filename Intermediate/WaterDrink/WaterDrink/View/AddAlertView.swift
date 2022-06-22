//
//  AddAlertView.swift
//  WaterDrink
//
//  Created by Sang hun Lee on 2022/05/14.
//

import Foundation
import UIKit
import SnapKit

class AddAlertView: UIView, ViewRepresentable {
    let timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "시간"
        return label
    }()
    
    let datePicker: UIDatePicker = {
       let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .time
        datePicker.locale = Locale(identifier: "ko")
        
        return datePicker
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
        addSubview(timeTitleLabel)
        addSubview(datePicker)
    }
    
    func setupConstraints() {
        timeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(80)
            $0.leading.equalTo(20)
        }
        
        datePicker.snp.makeConstraints {
            $0.width.equalTo(193)
            $0.height.equalTo(50)
            $0.trailing.equalTo(-20)
            $0.centerY.equalTo(timeTitleLabel.snp.centerY)
        }
    }
}
