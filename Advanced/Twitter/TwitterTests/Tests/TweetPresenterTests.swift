//
//  TweetPresenterTests.swift
//  TwitterTests
//
//  Created by Sang hun Lee on 2022/07/20.
//

import XCTest
@testable import Twitter

class TweetPresenterTests: XCTestCase {
    var sut: TweetPresenter!
    var viewController: MockTweetViewController!
    var tweet: Tweet!
    
    override func setUp() {
        super.setUp()
        viewController = MockTweetViewController()
        tweet = Tweet(
            user: User(name: "Test", account: "Test"),
            contents: "Test"
        )
        sut = TweetPresenter(
            viewController: viewController,
            tweet: tweet
        )
    }
    
    override func tearDown() {
        sut = nil
        tweet = nil
        viewController = nil
        super.tearDown()
    }
   
    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()
    
        XCTAssertTrue(viewController.isCalledConfigureView)
        XCTAssertTrue(viewController.isCalledSetupView)
        XCTAssertTrue(viewController.isCalledSetupConstraints)
    }
}
