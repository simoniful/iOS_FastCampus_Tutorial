//
//  MockTweetViewController.swift
//  TwitterTests
//
//  Created by Sang hun Lee on 2022/07/20.
//

import Foundation
@testable import Twitter

final class MockTweetViewController: TweetProtocol {
    var isCalledSetupView = false
    var isCalledSetupConstraints = false
    var isCalledConfigureView = false
    
    func setupView() {
        isCalledSetupView = true
    }
    
    func setupConstraints() {
        isCalledSetupConstraints = true
    }
    
    func configureView(tweet: Tweet) {
        isCalledConfigureView = true
    }
}
