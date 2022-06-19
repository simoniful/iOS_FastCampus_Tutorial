//
//  Language.swift
//  Translator
//
//  Created by Sang hun Lee on 2022/06/18.
//

import Foundation

enum Language: String, CaseIterable, Codable {
    case korean
    case english
    case japanese
    case chinese
    
    var title: String {
        switch self {
        case .korean:
            return "한국어"
        case .english:
            return "영어"
        case .japanese:
            return "일본어"
        case .chinese:
            return "중국어"
        }
    }
    
    var languageCode: String {
        switch self {
        case .korean:
            return "ko"
        case .english:
            return "en"
        case .japanese:
            return "ja"
        case .chinese:
            return "zn-CN"
        }
    }
}
