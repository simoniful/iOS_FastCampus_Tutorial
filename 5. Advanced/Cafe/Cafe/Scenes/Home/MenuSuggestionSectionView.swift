//
//  MenuSuggestionSectionView.swift
//  Cafe
//
//  Created by Sang hun Lee on 2022/06/16.
//

import Foundation
import SwiftUI

struct MenuSuggestionSectionView: View {
    @Binding var coffeeMenus: [CoffeeMenu]
    
    var body: some View {
        VStack {
            Text(User.shared.username + "님을 위한 추천메뉴")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16.0)
                
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(coffeeMenus) { menu in
                        MenuSuggestionItemView(coffeeMenu: menu)
                    }
                }
                .padding(.horizontal, 16.0)
            }
        }
    }
}

struct MenuSuggestionItemView: View {
    let coffeeMenu: CoffeeMenu
    
    var body: some View {
        VStack {
            coffeeMenu.image
                .resizable()
                .frame(width: 100.0, height: 100.0)
                .clipShape(Circle())
            Text(coffeeMenu.name)
                .font(.caption)
        }
    }
}
