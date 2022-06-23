//
//  MovieRatingUITests.swift
//  MovieRatingUITests
//
//  Created by Sang hun Lee on 2022/06/22.
//

import XCTest

class MovieRatingUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func test_navigationBar의_title이_영화평점으로_설정되어있다() {
        let existNavigationBar = app.navigationBars["영화 평점"].exists
        XCTAssertTrue(existNavigationBar)
    }
    
    func test_searchBar가_존재한다() {
        let existSearchBar = app.navigationBars["영화 평점"]
            .searchFields["Search"]
            .exists
        
        XCTAssertTrue(existSearchBar)
    }
    
    func test_searchBar에_cancel버튼이_존재한다() {
        let navigationBar = app.navigationBars["영화 평점"]
        navigationBar
            .searchFields["Search"]
            .tap()
            
        let existCancelButtonInSearchBar = navigationBar
            .buttons["Cancel"]
            .exists
        
        XCTAssertTrue(existCancelButtonInSearchBar)
    }
    
    enum CellData: String {
        case existMovie = "얼굴 보니 좋네"
        case notExistMovie = "해리포터"
    }
    
    // BDD
    func test_영화가_즐겨찾기_되어있으면() {
        let existsCell = app.collectionViews
            .cells
            .containing(.staticText, identifier: CellData.existMovie.rawValue)
            .element
            .exists
        
        XCTAssertTrue(existsCell, "Title이 표시된 Cell이 존재합니다.")
    }
    
    func test_영화가_즐겨찾기_되어있지_않으면() {
        let existsCell = app.collectionViews
            .cells
            .containing(.staticText, identifier: CellData.notExistMovie.rawValue)
            .element
            .exists
        
        XCTAssertFalse(existsCell, "Title이 표시된 Cell이 존재하지 않습니다.")
    }
}
