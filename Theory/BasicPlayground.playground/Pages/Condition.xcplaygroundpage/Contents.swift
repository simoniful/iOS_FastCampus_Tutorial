//: [Previous](@previous)

import Foundation

let age = 20

if age < 19 {
    print("미성년자")
} else {
    print("성년")
}

let animal = "cat"

if animal == "dog" {
    print("강아지")
} else if animal == "cat" {
    print("고양이")
} else {
    print("없음")
}

enum color {
    case green
    case red
    case blue
}

let labelColor: color = .red

switch labelColor {
case .green:
    print("초록")
case .red:
    print("빨강")
case .blue:
    print("파란")
default:
    print("없음")
}

let temperature = 30

switch temperature {
case -30...9:
    print("겨울")
case 10...16:
    print("가을")
case 17...25:
    print("봄")
case 26...40:
    print("여름")
default:
    print("이상 기온")
}

//: [Next](@next)
