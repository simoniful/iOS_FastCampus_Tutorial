//
//  MockReviewWriteViewController.swift
//  BookReviewTests
//
//  Created by Sang hun Lee on 2022/06/22.
//

import Foundation
@testable import BookReview

final class MockReviewWriteViewController: ReviewWriteProtocol {
    var isCalledSetupNavigationBar = false
    var isCalledShowCloseAlertController = false
    var isCalledClose = false
    var isCalledSetupView = false
    var isCalledPresentToSearchBookViewController = false
    var isCalledUpdateView = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func showCloseAlertController() {
        isCalledShowCloseAlertController = true
    }
    
    func close() {
        isCalledClose = true
    }
    
    func setupView() {
        isCalledSetupView = true
    }
    
    func presentToSearchBookViewController() {
        isCalledPresentToSearchBookViewController = true
    }
    
    func updateView(_ book: Book) {
        isCalledUpdateView = true
    }
    
    
}
