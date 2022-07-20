//
//  FeedPresenterTests.swift
//  TwitterTests
//
//  Created by Sang hun Lee on 2022/07/20.
//

import XCTest
@testable import Twitter

class FeedPresenterTests: XCTestCase {
    var sut: FeedPresenter!
    var viewController: MockFeedViewController!
    var userDefaultManager: MockUserDefaultManager!
    
    override func setUp() {
        super.setUp()
        viewController = MockFeedViewController()
        userDefaultManager = MockUserDefaultManager()
        sut = FeedPresenter(
            viewController: viewController,
            userDefaultManager: userDefaultManager
        )
    }
    
    override func tearDown() {
        sut = nil
        userDefaultManager = nil
        viewController = nil
        super.tearDown()
    }
    
    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupView)
        XCTAssertTrue(viewController.isCalledSetupConstraints)
    }
    
    func test_viewWillAppear가_요청되면() {
        sut.viewWillAppear()
        
        XCTAssertTrue(userDefaultManager.isCalledGetTweet)
        XCTAssertTrue(viewController.isCalledReloadTableView)
    }
    
    func test_didTapWriteButton가_요청되면() {
        sut.didTapWriteButton()
        
        XCTAssertTrue(viewController.isCalledPresentWriteViewController)
    }
}


