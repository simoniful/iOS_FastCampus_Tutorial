//
//  WritePresenterTests.swift
//  TwitterTests
//
//  Created by Sang hun Lee on 2022/07/20.
//

import XCTest
@testable import Twitter

class WritePresenterTests: XCTestCase {
    var sut: WritePresenter!
    var viewController: MockWriteViewController!
    var userDefaultManager: MockUserDefaultManager!
    
    override func setUp() {
        super.setUp()
        viewController = MockWriteViewController()
        userDefaultManager = MockUserDefaultManager()
        sut = WritePresenter(
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
        
        XCTAssertTrue(viewController.isCalledSetupNavigation)
        XCTAssertTrue(viewController.isCalledSetupView)
        XCTAssertTrue(viewController.isCalledSetupConstraints)
    }
    
    func test_didTapLeftBarButtonItem가_요청되면() {
        sut.didTapLeftBarButtonItem()
        
        XCTAssertTrue(viewController.isCalledDismiss)
    }
    
    func test_didTapRightBarButtonItem가_요청되면() {
        sut.didTapRightBarButtonItem(text: "Test")
        
        XCTAssertTrue(userDefaultManager.isCalledSetTweet)
        XCTAssertTrue(viewController.isCalledDismiss)
    }
}
