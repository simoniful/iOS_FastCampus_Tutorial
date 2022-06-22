//
//  MockUserDefaultsManager.swift
//  BookReviewTests
//
//  Created by Sang hun Lee on 2022/06/22.
//

import Foundation
@testable import BookReview

final class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    var isCalledGetReview = false
    var isCalledSetReview = false
    
    func getReview() -> [BookReview] {
        isCalledGetReview = true
        return []
    }
    
    func setReview(_ newValue: BookReview) {
        isCalledSetReview = true
    }
}
