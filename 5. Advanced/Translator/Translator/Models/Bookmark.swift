//
//  Bookmark.swift
//  Translator
//
//  Created by Sang hun Lee on 2022/06/18.
//

import Foundation

struct Bookmark: Codable {
    let sourceLanguage: Language
    let translatedLanguage: Language
    
    let sourceText: String
    let translatedText: String
}


