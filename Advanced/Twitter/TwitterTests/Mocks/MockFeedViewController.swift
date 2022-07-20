//
//  MockFeedViewController.swift
//  TwitterTests
//
//  Created by Sang hun Lee on 2022/07/20.
//

import Foundation
@testable import Twitter

final class MockFeedViewController: FeedProtocol {
    var isCalledSetupView = false
    var isCalledSetupConstraints = false
    var isCalledReloadTableView = false
    var isCalledPushToTweetViewController = false
    var isCalledPresentWriteViewController = false
    
    func setupView() {
        isCalledSetupView = true
    }
    
    func setupConstraints() {
        isCalledSetupConstraints = true
    }
    
    func reloadTableView() {
        isCalledReloadTableView = true
    }
    
    func pushToTweetViewController(with tweet: Tweet) {
        isCalledPushToTweetViewController = true
    }
    
    func presentWriteViewController() {
        isCalledPresentWriteViewController = true
    }
}
