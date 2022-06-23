//
//  Movie.swift
//  MovieRating
//
//  Created by Sang hun Lee on 2022/06/22.
//

import Foundation

struct Movie: Codable {
    let title: String
    let link: String
    private let image: String
    let subtitle: String
    let pubDate: String
    let director: String
    let actor: String
    let userRating: String
    var isLiked: Bool
    
    var imageURL: URL? { URL(string: image) }
    
    private enum CodingKeys: String, CodingKey {
        case title, link, image, subtitle, pubDate, director, actor, userRating
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        link = try container.decodeIfPresent(String.self, forKey: .link) ?? ""
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle) ?? ""
        pubDate = try container.decodeIfPresent(String.self, forKey: .pubDate) ?? ""
        director = try container.decodeIfPresent(String.self, forKey: .director) ?? ""
        actor = try container.decodeIfPresent(String.self, forKey: .actor) ?? ""
        userRating = try container.decodeIfPresent(String.self, forKey: .userRating) ?? ""
        isLiked = false
    }
    
    init(
        title: String,
        link: String,
        image: String,
        subtitle: String,
        pubDate: String,
        director: String,
        actor: String,
        userRating: String,
        isLiked: Bool = false
    ) {
        self.title = title
        self.link = link
        self.image = image
        self.subtitle = subtitle
        self.pubDate = pubDate
        self.director = director
        self.actor = actor
        self.userRating = userRating
        self.isLiked = isLiked
    }
}
