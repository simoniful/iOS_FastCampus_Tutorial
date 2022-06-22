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
            title: "스위프트 프로그래밍 (객체지향,함수형,프로토콜 지향 패러다임까지 한 번에!,<b>Swift</b> 5)",
            image: Optional("https://bookthumb-phinf.pstatic.net/cover/154/795/15479573.jpg?type=m1&udate=20191030"),
            author: "야곰",
            description: "문법을 넘어 프로그래밍 패러다임도 익히는 스위프트 5\n\n스위프트 5의 핵심 키워드는 ‘안정화’다. ABI 안정화 덕분에 버전과 환경에 크게 영향받지 않고 더 유연하게 스위프트를 사용할 수 있게 되었다. 최신 패러다임과 다양한 언어의 기능을 흡수하여 언어 전반에 걸쳐 안정화되었다. 기존 스위프트... ",
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
            title: "스위프트 프로그래밍 (객체지향,함수형,프로토콜 지향 패러다임까지 한 번에!,<b>Swift</b> 5)",
            image: Optional("https://bookthumb-phinf.pstatic.net/cover/154/795/15479573.jpg?type=m1&udate=20191030"),
            author: "야곰",
            description: "문법을 넘어 프로그래밍 패러다임도 익히는 스위프트 5\n\n스위프트 5의 핵심 키워드는 ‘안정화’다. ABI 안정화 덕분에 버전과 환경에 크게 영향받지 않고 더 유연하게 스위프트를 사용할 수 있게 되었다. 최신 패러다임과 다양한 언어의 기능을 흡수하여 언어 전반에 걸쳐 안정화되었다. 기존 스위프트... ",
            publisher: "한빛미디어"
        )
        sut.didTapRightBarButton(contentsText: nil)
        
        XCTAssertFalse(userDefaultManager.isCalledSetReview)
        XCTAssertFalse(viewController.isCalledClose)
    }
    
    func test_didTapRightBarButton_book이_존재_contentsText가_PlaceHolder와_같으면() {
        // guard 문 통과를 위한 Mock-up
        sut.book = Book(
            title: "스위프트 프로그래밍 (객체지향,함수형,프로토콜 지향 패러다임까지 한 번에!,<b>Swift</b> 5)",
            image: Optional("https://bookthumb-phinf.pstatic.net/cover/154/795/15479573.jpg?type=m1&udate=20191030"),
            author: "야곰",
            description: "문법을 넘어 프로그래밍 패러다임도 익히는 스위프트 5\n\n스위프트 5의 핵심 키워드는 ‘안정화’다. ABI 안정화 덕분에 버전과 환경에 크게 영향받지 않고 더 유연하게 스위프트를 사용할 수 있게 되었다. 최신 패러다임과 다양한 언어의 기능을 흡수하여 언어 전반에 걸쳐 안정화되었다. 기존 스위프트... ",
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
