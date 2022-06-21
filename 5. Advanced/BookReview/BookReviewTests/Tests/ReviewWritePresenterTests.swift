//
//  ReviewWritePresenterTest.swift
//  BookReviewTests
//
//  Created by Sang hun Lee on 2022/06/21.
//

import XCTest
@testable import BookReview

class ReviewWritePresenterTests: XCTestCase {
    var sut: ReviewWritePresenter!
    var viewController: MockReviewWriteViewController!
    var userDefaultManager: MockUserDefaultsManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockReviewWriteViewController()
        userDefaultManager = MockUserDefaultsManager()
        
        sut = ReviewWritePresenter(
            viewController: viewController,
            userDefaultManager: userDefaultManager
        )
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
    
    func test_didTapLeftBarButton() {
        sut.didTapLeftBarButton()
        
        XCTAssertTrue(viewController.isCalledShowCloseAlertController)
    }
    
    // 다양한 분기에 따라 나누어서 Test Case 구성
    func test_didTapRightBarButton_book이_존재_contentsText가_PlaceHolder와_같지_않게_존재하면() {
        // guard 문 통과를 위한 Mock-up
        sut.book = Book(
            title: "Swift",
            image: "",
            author: "정재은",
            description: "swift 4.0에 맞춘",
            publisher: "한빛미디어"
        )
        sut.didTapRightBarButton(contentsText: "공부하기 좋은 책")
        
        XCTAssertTrue(userDefaultManager.isCalledSetReview)
        XCTAssertTrue(viewController.isCalledClose)
    }
    
    func test_didTapRightBarButton_book이_존재하지_않으면() {
        sut.book = nil
        sut.didTapRightBarButton(contentsText: "공부하기 좋은 책")
        
        XCTAssertFalse(userDefaultManager.isCalledSetReview)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapRightBarButton_book이_존재_contentsText가_존재하지_않으면() {
        sut.book = Book(
            title: "Swift",
            image: "",
            author: "정재은",
            description: "swift 4.0에 맞춘",
            publisher: "한빛미디어"
        )
        sut.didTapRightBarButton(contentsText: nil)
        
        XCTAssertFalse(userDefaultManager.isCalledSetReview)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapRightBarButton_book이_존재_contentsText가_PlaceHolder와_같으면() {
        // guard 문 통과를 위한 Mock-up
        sut.book = Book(
            title: "Swift",
            image: "",
            author: "정재은",
            description: "swift 4.0에 맞춘",
            publisher: "한빛미디어"
        )
        sut.didTapRightBarButton(contentsText: sut.contentTextViewPlaceHolderText)
        
        XCTAssertFalse(userDefaultManager.isCalledSetReview)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapBookTitleButton() {
        sut.didTapBookTitleButton()
        
        XCTAssertTrue(viewController.isCalledPresentToSearchBookViewController)
    }
}
