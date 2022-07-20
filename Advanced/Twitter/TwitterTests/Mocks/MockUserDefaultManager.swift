//
//  MockUserDefaultManager.swift
//  TwitterTests
//
//  Created by Sang hun Lee on 2022/07/20.
//

import Foundation
@testable import Twitter

final class MockUserDefaultManager: UserDefaultManagerProtocol {
    var tweets: [Tweet] = []
    var newTweet: Tweet!
    
    var isCalledGetTweet = false
    var isCalledSetTweet = false
    
    func getTweet() -> [Tweet] {
        isCalledGetTweet = true
        return tweets
    }
    
    func setTweet(_ newValue: Tweet) {
        isCalledSetTweet = true
    }
}
