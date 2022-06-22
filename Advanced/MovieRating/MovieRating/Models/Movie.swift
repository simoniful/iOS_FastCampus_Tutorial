//
//  Movie.swift
//  MovieRating
//
//  Created by Sang hun Lee on 2022/06/22.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let link: String
    private let image: String
    let subtitle: String
    let pubDate: String
    let director: String
    let actor: String
    let userRating: String
    
    var imageURL: URL? { URL(string: image) }
    
    init(
        title: String,
        link: String,
        image: String,
        subtitle: String,
        pubDate: String,
        director: String,
        actor: String,
        userRating: String
    ) {
        self.title = title
        self.link = link
        self.image = image
        self.subtitle = subtitle
        self.pubDate = pubDate
        self.director = director
        self.actor = actor
        self.userRating = userRating
    }
}
