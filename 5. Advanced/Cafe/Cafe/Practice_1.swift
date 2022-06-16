//
//  Practice.swift
//  Cafe
//
//  Created by Sang hun Lee on 2022/06/16.
//

import SwiftUI

// HStack
//struct SampleHStack: View {
//    var body: some View {
//        ScrollView(.horizontal) {
//            HStack {
//                // 최대 10개
//                Text("HStack 알아보기")
//                Text("HStack 알아보기")
//                Text("HStack 알아보기")
//                Text("HStack 알아보기")
//                Text("HStack 알아보기")
//                Text("HStack 알아보기")
//                Text("HStack 알아보기")
//                Text("HStack 알아보기")
//                Text("HStack 알아보기")
//                Text("HStack 알아보기")
//            }
//        }
//    }
//}
//
//struct SampleHStack_Previews: PreviewProvider {
//    static var previews: some View {
//        SampleHStack()
//    }
//}

// LazyHStack - scrollView
//struct SampleLazyHStack: View {
//
//    struct Number: Identifiable {
//        let value: Int
//        var id: Int { value }
//    }
//
//    let nums: [Number] = (0...100).map { Number(value: $0) }
//
//    var body: some View {
//        ScrollView(.horizontal) {
//            LazyHStack {
//                // 최대 31개 init
//                ForEach(nums) { num in
//                    Text("\(num.value)")
//                }
//            }
//        }
//    }
//}
//
//struct SampleLazyHStack_Previews: PreviewProvider {
//    static var previews: some View {
//        SampleLazyHStack()
//    }
//}

//struct SampleLazyHGrid: View {
//
//    struct Number: Identifiable {
//        let value: Int
//        var id: Int { value }
//    }
//
//    let nums: [Number] = (1...100).map { Number(value: $0) }
//
//    var body: some View {
//        ScrollView(.horizontal) {
//            LazyHGrid(
//                rows: [
//                    GridItem(.fixed(50)),
//                    GridItem(.fixed(40)),
//                    GridItem(.fixed(30)),
//                    GridItem(.fixed(20)),
//                    GridItem(.fixed(10))
//                ]
//            ) {
//                // 최대 31개 init
//                ForEach(nums) { num in
//                    Text("\(num.value)")
//                }
//            }
//        }
//    }
//}
//
//struct SampleLazyHGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        SampleLazyHGrid()
//    }
//}

struct SampleList: View {
    
    struct Number: Identifiable {
        let value: Int
        var id: Int { value }
    }
    
    let nums: [Number] = (1...100).map { Number(value: $0) }
    
    var body: some View {
        List {
            Section(header: Text("Header 1")) {
                ForEach(nums) { num in
                    Text("\(num.value)")
                }
            }
            
            Section(header: Text("Header 2"), footer: Text("Footer 2")) {
                ForEach(nums) { num in
                    Text("\(num.value)")
                }
            }
        }
    }
}

struct SampleList_Previews: PreviewProvider {
    static var previews: some View {
        SampleList()
    }
}

