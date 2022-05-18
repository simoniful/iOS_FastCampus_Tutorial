//
//  MyView.swift
//  AssetManagement
//
//  Created by Sang hun Lee on 2022/05/18.
//

import SwiftUI

// 기능에 대한 청사진
// 화면에 그리는 요소를 나타냄
struct MyView: View {
    let helloFont: Font
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .font(helloFont)
            Text("안녕, 세상!")
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView(helloFont: .title)
    }
}
