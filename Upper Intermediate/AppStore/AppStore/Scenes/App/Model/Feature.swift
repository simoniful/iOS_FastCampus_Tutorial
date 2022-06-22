//
//  Feature.swift
//  AppStore
//
//  Created by Sang hun Lee on 2022/05/25.
//

import Foundation

struct Feature: Decodable {
    var type: String
    var appName: String
    var description: String
    var imageURL: String
}
