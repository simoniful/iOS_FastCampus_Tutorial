//
//  TranslateRequestModel.swift
//  Translator
//
//  Created by Sang hun Lee on 2022/06/20.
//

import Foundation

struct TranslateRequestModel: Codable {
    let source: String
    let target: String
    let text: String
}
