//
//  ButtonIcon.swift
//  Twitter
//
//  Created by Sang hun Lee on 2022/07/18.
//

import UIKit

enum ButtonIcon {
    case like
    case message
    case share
    case write
    
    var image: UIImage? {
        let systemName: String
        
        switch self {
        case .like:
            systemName = "heart"
        case .message:
            systemName = "message"
        case .share:
            systemName = "square.and.arrow.up"
        case .write:
            systemName = "square.and.pencil"
        }
        
        return UIImage(systemName: systemName)
    }
}
