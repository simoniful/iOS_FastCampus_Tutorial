//
//  Content.swift
//  MovieRecommend
//
//  Created by Sang hun Lee on 2022/05/16.
//

import Foundation
import UIKit


struct Content: Decodable {
    var sectionType: SectionType
    var sectionName: String
    var contentItem: [Item]
    
    enum SectionType: String, Decodable {
        case basic
        case large
        case main
        case rank
    }
}

struct Item: Decodable {
    var description: String
    var imageName: String
     
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
}
