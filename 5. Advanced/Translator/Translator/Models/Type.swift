//
//  Type.swift
//  Translator
//
//  Created by Sang hun Lee on 2022/06/19.
//

import UIKit

enum `Type` {
    case source
    case target
    
    var color: UIColor {
        switch self {
        case .source: return .label
        case .target: return .mainTintColor
        }
    }
}
