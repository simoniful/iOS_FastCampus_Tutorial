//
//  SearchBookPresenterTests.swift
//  BookReviewTests
//
//  Created by Sang hun Lee on 2022/06/22.
//

import XCTest
@testable import BookReview

final class SearchBookPresenterTests: XCTestCase {
    var sut: SearchBookPresenter!
    
    var viewController: MockSearchBookViewController!
    var bookSearchManager: MockBookSearchManager!
    var delegate: MockReviewWriteViewController!
    
    override func setUp() {
        viewController = MockSearchBookViewController()
        bookSearchManager = MockBookSearchManager()
        delegate = MockReviewWriteViewController()
        
        sut = SearchBookPresenter(
            viewController: viewController,
            delegate: delegate,
            bookSearchManager: bookSearchManager
        )
    }
    
    override func tearDown() {
        sut = nil
        viewController = nil
        delegate = nil
        
        super.tearDown()
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupView)
    }
    
    // 기본적으로 동작이 되는지만 확인
    // Mock 구성에 대해 알고 있으면 저로 비교하여 확실한 데이터가 오는지 확인 가능할듯
    // 인스턴스로 searchBar에 text를 안 넣는 거로 구성해도 통과 발생 - 실기기 환경과의 차이
    // 공백 처리에 대해서 구성해야 안전할 듯
    func test_searchBarSearchButtonClicked() {
        let searchBar = UISearchBar()
        searchBar.text = "swift"
        sut.searchBarSearchButtonClicked(searchBar)
        
        XCTAssertTrue(bookSearchManager.isCalledRequest)
    }
    
    // Mock-up에 대한 부분은 테스트에 있어서 별도로 관리 필요
    func test_didSelectRowAt() {
        sut.books = [
            Book(
                title: "스위프트 프로그래밍 (객체지향,함수형,프로토콜 지향 패러다임까지 한 번에!,<b>Swift</b> 5)",
                image: Optional("https://bookthumb-phinf.pstatic.net/cover/154/795/15479573.jpg?type=m1&udate=20191030"),
                author: "야곰",
                description: "문법을 넘어 프로그래밍 패러다임도 익히는 스위프트 5\n\n스위프트 5의 핵심 키워드는 ‘안정화’다. ABI 안정화 덕분에 버전과 환경에 크게 영향받지 않고 더 유연하게 스위프트를 사용할 수 있게 되었다. 최신 패러다임과 다양한 언어의 기능을 흡수하여 언어 전반에 걸쳐 안정화되었다. 기존 스위프트... ",
                publisher: "한빛미디어")
        ]
        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(delegate.isCalledSelectBook)
        XCTAssertTrue(viewController.isCalledDismiss)
    }
}
