//
//  MockWriteViewController.swift
//  TwitterTests
//
//  Created by Sang hun Lee on 2022/07/20.
//

import Foundation
@testable import Twitter

final class MockWriteViewController: WriteProtocol {
    var isCalledSetupView = false
    var isCalledSetupConstraints = false
    var isCalledSetupNavigation = false
    var isCalledDismiss = false
    
    func setupView() {
        isCalledSetupView = true
    }
    
    func setupConstraints() {
        isCalledSetupConstraints = true
    }
    
    func setupNavigation() {
        isCalledSetupNavigation = true
    }
    
    func dismiss() {
        isCalledDismiss = true
    }
}
