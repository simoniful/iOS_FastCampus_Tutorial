//
//  MockBookSearchManager.swift
//  BookReviewTests
//
//  Created by Sang hun Lee on 2022/06/22.
//

import Foundation
@testable import BookReview

final class MockBookSearchManager: BookSearchManagerProtocol {
    var isCalledRequest = false
    
    func request(from keyword: String, completionHandler: @escaping ([Book]) -> ()) {
        isCalledRequest = true
    }
}
