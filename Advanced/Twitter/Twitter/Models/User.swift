//
//  User.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/18.
//

import Foundation

struct User: Codable {
    var name: String
    var account: String
    
    static var shared = User(name: "사이먼", account: "simoniful")
}
