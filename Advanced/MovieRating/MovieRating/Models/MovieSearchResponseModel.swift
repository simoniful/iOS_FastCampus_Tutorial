//
//  MovieSearchResponseModel.swift
//  MovieRating
//
//  Created by Sang hun Lee on 2022/06/22.
//

import Foundation

struct MovieSearchResponseModel: Decodable {
    var items: [Movie] = []
}
