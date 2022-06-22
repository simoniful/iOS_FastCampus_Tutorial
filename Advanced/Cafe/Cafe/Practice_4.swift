//
//  Practice_4.swift
//  Cafe
//
//  Created by Sang hun Lee on 2022/06/16.
//

import SwiftUI

class ButtonModel: ObservableObject {
    @Published var isDisabled = true
}

struct ParentView: View {
    @ObservedObject var buttonModel = ButtonModel()
    // @State private var isDisabled = true
    var body: some View {
        ChildView(isDisabled: $buttonModel.isDisabled)
    }
}

struct ChildView: View {
    @Binding var isDisabled: Bool
    
    var body: some View {
        VStack {
            Toggle(isOn: $isDisabled, label: {
                Text("버튼을 비활성화 시키겠습니까?")
            })
            
            Button("버튼") {}
                .disabled(isDisabled)
        }
    }
}

struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}
