//
//  MainView.swift
//  Covid-19
//
//  Created by Sang hun Lee on 2022/05/07.
//

import Foundation
import UIKit
import SnapKit

class MainView: UIView, ViewRepresentable {
    
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
        self.backgroundColor = .red
    }
    
    func setupConstraints() {
        
    }
}
