//
//  MainView.swift
//  RealtimeNotice
//
//  Created by Sang hun Lee on 2022/05/13.
//

import Foundation
import UIKit

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
        self.backgroundColor = .systemBackground
    }
    
    func setupConstraints() {
        
    }
}
