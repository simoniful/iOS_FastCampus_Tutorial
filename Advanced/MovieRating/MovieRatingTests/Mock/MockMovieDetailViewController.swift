//
//  MockMovieDetailViewController.swift
//  MovieRatingTests
//
//  Created by Sang hun Lee on 2022/06/23.
//

import Foundation
@testable import MovieRating

final class MockMovieDetailViewController: MovieDetailProtocol {
    var isCalledSetupView = false
    var isCalledSetRightBarButton = false
    
    var settedIsLiked = false
    
    func setupView(with movie: Movie) {
        isCalledSetupView = true
    }
    
    func setRightBarButton(with isLiked: Bool) {
        settedIsLiked = isLiked
        isCalledSetRightBarButton = true
    }
}
