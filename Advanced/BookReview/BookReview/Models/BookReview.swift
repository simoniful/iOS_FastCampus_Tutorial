//
//  BookReview.swift
//  BookReview
//
//  Created by Sang hun Lee on 2022/06/21.
//

import Foundation

struct BookReview: Codable {
    let title: String
    let contents: String
    let imageURL: URL?
}
