//
//  Event.swift
//  Cafe
//
//  Created by Sang hun Lee on 2022/06/16.
//

import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    
    let image: Image
    let title: String
    let description: String
    
//    static let sample: [Event] = [
//        Event(image: Image("coffee"), title: "오늘의 세일", description: "할인의 기회를 놓치지 마세요!"),
//        Event(image: Image("coffee"), title: "봄 한정 메뉴", description: "따뜻한 봄날의 벛꽃과 닳은 메뉴를 만나보세요!"),
//        Event(image: Image("coffee"), title: "여름 한정 메뉴", description: "더위를 한방에 날려줄 특별한 아이스커피!"),
//        Event(image: Image("coffee"), title: "가을 한정 메뉴", description: "풍성한 향기를 가진 메뉴를 만나보세요!"),
//        Event(image: Image("coffee"), title: "겨울 한정 메뉴", description: "추운 겨울 몸을 따뜻하게 할 음료 추천!"),
//    ]
}
