//
//  MockMovieSearchManager.swift
//  MovieRatingTests
//
//  Created by Sang hun Lee on 2022/06/23.
//

import Foundation
@testable import MovieRating

final class MockMovieSearchManager: MovieSearchManagerProtocol {
    var isCalledRequest = false
    
    var needToSuccessRequest = false
    
    func request(from keyword: String, completionHandler: @escaping ([Movie]) -> Void) {
        isCalledRequest = true
        
        if needToSuccessRequest {
            completionHandler([])
        }
    }
}
