//
//  User.swift
//  Cafe
//
//  Created by Sang hun Lee on 2022/06/16.
//

import Foundation

struct User {
    let username: String
    let account: String

    static let shared = User(username: "Simon", account: "simoniful0@gmail.com")
}
