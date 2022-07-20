//
//  MockProfileViewController.swift
//  TwitterTests
//
//  Created by Sang hun Lee on 2022/07/20.
//

import Foundation
@testable import Twitter

final class MockProfileViewController: ProfileProtocol {
    var isCalledSetupView = false
    var isCalledSetupConstraints = false
    var isCalledSetupNavigation = false
    var isCalledConfigureView = false
    var isCalledEndEditing = false
    var isCalledShowToast = false
    
    func setupView() {
        isCalledSetupView = true
    }
    
    func setupConstraints() {
        isCalledSetupConstraints = true
    }
    
    func setupNavigation() {
        isCalledSetupNavigation = true
    }
    
    func configureView(with name: String, account: String) {
        isCalledConfigureView = true
    }
    
    func endEditing() {
        isCalledEndEditing = true
    }
    
    func showToast(message: String) {
        isCalledShowToast = true
    }
}
