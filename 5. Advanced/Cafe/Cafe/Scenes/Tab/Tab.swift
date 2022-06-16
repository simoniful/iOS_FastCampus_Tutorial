//
//  Tab.swift
//  Cafe
//
//  Created by Sang hun Lee on 2022/06/15.
//

import Foundation
import SwiftUI

enum Tab {
    case home
    case other
    
    // associated value
    var textItem: Text {
        switch self {
        case .home:
            return Text("Home")
        case .other:
            return Text("Other")
        }
    }
    
    var imageItem: Image {
        switch self {
        case .home:
            return Image(systemName: "house.fill")
        case .other:
            return Image(systemName: "ellipsis")
        }
    }
}
