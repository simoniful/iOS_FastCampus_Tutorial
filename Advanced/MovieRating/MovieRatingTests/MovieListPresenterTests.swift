//
//  MovieListPresenterTests.swift
//  MovieRatingTests
//
//  Created by Sang hun Lee on 2022/06/23.
//

import XCTest
@testable import MovieRating

class MovieListPresenterTests: XCTestCase {
    var sut: MovieListPresenter!
    
    var viewController: MockMovieListViewController!
    var userDefaultsManager: MockUserDefaultsManager!
    var movieSearchManager: MockMovieSearchManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockMovieListViewController()
        userDefaultsManager = MockUserDefaultsManager()
        movieSearchManager = MockMovieSearchManager()
        
        sut = MovieListPresenter(
            viewController: viewController,
            userDefaultsManager: userDefaultsManager,
            movieSearchManager: movieSearchManager
        )
    }
    
    override func tearDown() {
        sut = nil
        
        viewController = nil
        userDefaultsManager = nil
        movieSearchManager = nil
        
        super.tearDown()
    }
    
    // request 메서드가 성공/실패 여부, 조건 분기 = 시나리오 기반 테스트 진행 가능
    // 성공 - updateSearchTableView 메서드 호출
    // 실패 - updateSearchTableView 메서드 호출 X
    func test_searchBar_textDidChange가_호출될_때_request가_성공하면() {
        movieSearchManager.needToSuccessRequest = true
        sut.searchBar(UISearchBar(), textDidChange: "")
        
        XCTAssertTrue(viewController.isCalledUpdateSearchTableView, "updateSearchTableView가 실행된다")
    }
    
    func test_searchBar_textDidChange가_호출될_때_request가_실패하면() {
        movieSearchManager.needToSuccessRequest = false
        sut.searchBar(UISearchBar(), textDidChange: "")
        
        XCTAssertFalse(viewController.isCalledUpdateSearchTableView, "updateSearchTableView가 실행되지 않는다")
    }
    
    func test_viewDidLoad가_호출되면() {
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupSearchBar)
        XCTAssertTrue(viewController.isCalledSetupView)
    }
    
    func test_viewWillAppear가_호출되면() {
        sut.viewWillAppear()
        
        XCTAssertTrue(userDefaultsManager.isCalledGetMovies)
        XCTAssertTrue(viewController.isCalledUpdateCollectionView)
    }
    
    func test_searchBarTextDidBeginEditing가_호출되면() {
        sut.searchBarTextDidBeginEditing(UISearchBar())
        
        XCTAssertTrue(viewController.isCalledUpdateSearchTableView)
    }
    
    func test_searchBarCancelButtonClicked가_호출되면() {
        sut.searchBarTextDidBeginEditing(UISearchBar())
        
        XCTAssertTrue(viewController.isCalledUpdateSearchTableView)
    }
    
    func test_collectionView_didSelectItemAt가_호출되면() {
        sut.likedMovies = [
            Movie(
                title: "스타워즈: 라스트 제다이",
                link: "https://movie.naver.com/movie/bi/mi/basic.nhn?code=125488",
                image: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1254/125488_P20_135324.jpg",
                subtitle: "<b>Star</b> <b>Wars</b>: The Last Jedi",
                pubDate: "2017",
                director: "라이언 존슨|",
                actor: "데이지 리들리|마크 해밀|오스카 아이삭|아담 드라이버|캐리 피셔|존 보예가|",
                userRating: "6.33",
                isLiked: true
            )
        ]
        
        sut.collectionView(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()), didSelectItemAt: IndexPath(item: 0, section: 0))
        
        XCTAssertTrue(viewController.isCalledPushToMovieDetailViewController)
    }
    
    func test_tableView_didSelectRowAt가_호출되면() {
        sut.currentMovieSearchResult = [
            Movie(
                title: "스타워즈: 라스트 제다이",
                link: "https://movie.naver.com/movie/bi/mi/basic.nhn?code=125488",
                image: "https://ssl.pstatic.net/imgmovie/mdi/mit110/1254/125488_P20_135324.jpg",
                subtitle: "<b>Star</b> <b>Wars</b>: The Last Jedi",
                pubDate: "2017",
                director: "라이언 존슨|",
                actor: "데이지 리들리|마크 해밀|오스카 아이삭|아담 드라이버|캐리 피셔|존 보예가|",
                userRating: "6.33",
                isLiked: false
            )
        ]
        
        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(viewController.isCalledPushToMovieDetailViewController)
    }
}



