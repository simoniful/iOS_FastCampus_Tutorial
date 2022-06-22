//
//  DaumKakaoBlog.swift
//  BlogCafeSearch
//
//  Created by Sang hun Lee on 2022/06/07.
//

import Foundation

// MARK: - DaumKakaoBlog
struct DaumKakaoBlog: Decodable {
    var documents: [Document]
    var meta: Meta
}

// MARK: - Document
struct Document: Decodable {
    var name, contents: String?
    var datetime: Date?
    var thumbnail: String?
    var title: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case title, thumbnail, url, contents, datetime
        case name = "blogname"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try? values.decode(String?.self, forKey: .title)
        self.name = try? values.decode(String?.self, forKey: .name)
        self.thumbnail = try? values.decode(String?.self, forKey: .thumbnail)
        self.url = try? values.decode(String?.self, forKey: .url)
        self.contents = try? values.decode(String?.self, forKey: .contents)
        self.datetime = Date.parse(values, key: .datetime)
    }
}

// MARK: - Meta
struct Meta: Decodable {
    var isEnd: Bool?
    var pageableCount, totalCount: Int?

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}


