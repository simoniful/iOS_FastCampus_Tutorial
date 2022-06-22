//
//  BookSearchRequestModel.swift
//  BookReview
//
//  Created by Sang hun Lee on 2022/06/21.
//

import Foundation

struct BookSearchRequestModel: Codable {
    /// 검색할 책 키워드
    let query: String
}
