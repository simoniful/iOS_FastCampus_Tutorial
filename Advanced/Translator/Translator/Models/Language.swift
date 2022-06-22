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
            return NSLocalizedString("Korean", comment: "한국어")
        case .english:
            return NSLocalizedString("English", comment: "영어")
        case .japanese:
            return NSLocalizedString("Japanese", comment: "일본어")
        case .chinese:
            return NSLocalizedString("Chinese", comment: "중국어")
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
