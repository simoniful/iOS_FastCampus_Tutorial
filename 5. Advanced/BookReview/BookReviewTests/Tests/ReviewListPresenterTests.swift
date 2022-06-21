//
//  ReviewListPresenterTest.swift
//  BookReviewTests
//
//  Created by Sang hun Lee on 2022/06/21.
//

import XCTest
@testable import BookReview

class ReviewListPresenterTests: XCTestCase {
    var sut: ReviewListPresenter!
    var viewController: MockReviewListViewController!
    var userDefaultManager: MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockReviewListViewController()
        userDefaultManager = MockUserDefaultsManager()
        
        sut = ReviewListPresenter(viewController: viewController, userDefaultManager: userDefaultManager)
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupView)
    }
    
    func test_didTapRightBarButtonItem() {
        sut.didTapRightBarButtonItem()
        
        XCTAssertTrue(viewController.isCalledPresentToReviewWriteViewController)
    }
    
    func test_viewWillAppear() {
        sut.viewWillAppear()
        
        XCTAssertTrue(userDefaultManager.isCalledGetReview)
        XCTAssertTrue(viewController.isCalledReloadTableView)
    }
}
