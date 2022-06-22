//
//  MockSearchBookViewController.swift
//  BookReviewTests
//
//  Created by Sang hun Lee on 2022/06/22.
//

import Foundation
@testable import BookReview

final class MockSearchBookViewController: SearchBookProtocol {
    var isCalledSetupView = false
    var isCalledDismiss = false
    var isCalledReloadTableView = false
    
    func setupView() {
        isCalledSetupView = true
    }
    
    func dismiss() {
        isCalledDismiss = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
}
