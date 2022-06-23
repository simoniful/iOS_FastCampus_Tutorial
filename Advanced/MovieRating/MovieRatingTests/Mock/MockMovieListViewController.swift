//
//  MockMovieListViewController.swift
//  MovieRatingTests
//
//  Created by Sang hun Lee on 2022/06/23.
//

import Foundation
@testable import MovieRating

// Cuckoo - 테스트용 Mock 파일을 자동으로 만들어주는 프레임 워크
final class MockMovieListViewController: MovieListProtocol {
    var isCalledSetupNavigationBar = false
    var isCalledSetupSearchBar = false
    var isCalledSetupView = false
    var isCalledUpdateSearchTableView = false
    var isCalledPushToMovieDetailViewController = false
    var isCalledUpdateCollectionView = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func setupSearchBar() {
        isCalledSetupSearchBar = true
    }
    
    func setupView() {
        isCalledSetupView = true
    }
    
    func updateSearchTableView(isHidden: Bool) {
        isCalledUpdateSearchTableView = true
    }
    
    func pushToMovieDetailViewController(with movie: Movie) {
        isCalledPushToMovieDetailViewController = true
    }
    
    func updateCollectionView() {
        isCalledUpdateCollectionView = true
    }
}
