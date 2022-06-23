//
//  MovieDetailPresenterTests.swift
//  MovieRatingTests
//
//  Created by Sang hun Lee on 2022/06/23.
//

import XCTest
@testable import MovieRating

class MovieDetailPresenterTests: XCTestCase {
    var sut: MovieDetailPresenter!
    
    var viewController: MockMovieDetailViewController!
    var userDefaultsManager: MockUserDefaultsManager!
    var movie: Movie!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockMovieDetailViewController()
        userDefaultsManager = MockUserDefaultsManager()
        movie = Movie(
            title: "스타워즈: 라스트 제다이",
            link: "https://movie.naver.com/movie/bi/mi/basic.nhn?code=125488",
            image: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1254/125488_P20_135324.jpg",
            subtitle: "<b>Star</b> <b>Wars</b>: The Last Jedi",
            pubDate: "2017",
            director: "라이언 존슨|",
            actor: "데이지 리들리|마크 해밀|오스카 아이삭|아담 드라이버|캐리 피셔|존 보예가|",
            userRating: "6.33"
        )
        
        sut = MovieDetailPresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager,
            movie: movie
        )
    }

    override func tearDown() {
        sut = nil
        
        viewController = nil
        userDefaultsManager = nil
    
        super.tearDown()
    }
    
    func test_viewDidLoad가_호출되면(){
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupView)
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }
    
    func test_didTapRightBarButtonItem이_호출될_때_isLiked가_true가_되면(){
        movie.isLiked = false
        
        sut = MovieDetailPresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager,
            movie: movie
        )
        
        sut.didTapRightBarButtonItem()
        
        XCTAssertTrue(userDefaultsManager.isCalledAddMovie)
        XCTAssertFalse(userDefaultsManager.isCalledRemoveMovie)
        
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }
    
    func test_didTapRightBarButtonItem이_호출될_때_isLiked가_false가_되면(){
        movie.isLiked = true
        
        sut = MovieDetailPresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager,
            movie: movie
        )
        
        sut.didTapRightBarButtonItem()
        
        XCTAssertFalse(userDefaultsManager.isCalledAddMovie)
        XCTAssertTrue(userDefaultsManager.isCalledRemoveMovie)
        
        XCTAssertTrue(viewController.isCalledSetRightBarButton)
    }
}
