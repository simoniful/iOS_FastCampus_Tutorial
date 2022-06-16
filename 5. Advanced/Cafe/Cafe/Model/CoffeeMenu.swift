//
//  CoffeeMenu.swift
//  Cafe
//
//  Created by Sang hun Lee on 2022/06/16.
//

import SwiftUI

struct CoffeeMenu: Identifiable {
    let image: Image // UIImage
    let name: String
    let id = UUID()
    
    static let sample: [CoffeeMenu] = [
        CoffeeMenu(image: Image("coffee"), name: "아메리카노"),
        CoffeeMenu(image: Image("coffee"), name: "카페라떼"),
        CoffeeMenu(image: Image("coffee"), name: "카푸치노"),
        CoffeeMenu(image: Image("coffee"), name: "드립커피"),
        CoffeeMenu(image: Image("coffee"), name: "콘파냐"),
        CoffeeMenu(image: Image("coffee"), name: "모카라떼")
    ]
}
