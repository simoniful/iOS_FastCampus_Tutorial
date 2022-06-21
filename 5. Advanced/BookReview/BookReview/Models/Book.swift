//
//  Book.swift
//  BookReview
//
//  Created by Sang hun Lee on 2022/06/21.
//

import Foundation

struct Book: Decodable {
    let title: String
    private let image: String?
    let author: String
    let description: String
    let publisher: String
    
    var imageURL: URL? {
        URL(string: image ?? "")
    }
}
