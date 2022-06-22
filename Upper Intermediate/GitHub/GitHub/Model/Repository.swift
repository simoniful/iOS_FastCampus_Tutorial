//
//  Repository.swift
//  GitHub
//
//  Created by Sang hun Lee on 2022/06/04.
//

import Foundation

struct Repository: Decodable {
    var id: Int
    var name: String
    var description: String
    var stargazersCount: Int
    var language: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case stargazersCount = "stargazers_count"
    }
}
