//
//  Practice_3.swift
//  Cafe
//
//  Created by Sang hun Lee on 2022/06/16.
//

import SwiftUI

struct SampleView_2: View {
//@State private var currentText = ""
    @State private var isDisabled = true
    
    var body: some View {
//        VStack {
//            TextField("텍스트를 입력해주세요", text: $currentText)
//            Text(currentText)
//        }
        VStack {
            Toggle(isOn: $isDisabled, label: {
                Text("버튼을 비활성화 시키겠습니까?")
            })
            
            Button("버튼") {}
                .disabled(isDisabled)
        }
    }
}

struct SampleView_2_Previews: PreviewProvider {
    static var previews: some View {
        SampleView_2()
    }
}
