//: [Previous](@previous)

import Foundation

var name: String?

// 옵셔널로 포장된 변수
var optionalName: String? = "Simon"

// 옵셔널 바인딩 필요
var requiredName: String = optionalName!

// 명시적 해제 - 강제해제 / 비강제해제(옵셔널바인딩)
var number: Int? = 3
print(number)
print(number!)

if let number = number {
    print(number)
}


func test() {
    let num: Int? = 5
    guard let result = num else { return }
    print(result)
}

test()

// 묵시적 해제 - 컴파일러에 의한 자동 해제 / 옵셔널의 묵시적 해제

// 비교 연산자를 이용해 값을 비교하면 컴파일러가 자동적으로 해제
let value: Int? = 6
if value == 6 {
    print("6임")
} else {
    print("6아님")
}

// 옵셔널의 묵시적 해제
// 타입 뒤 !: 사용할 때 묵시적으로 해제를 통해서 일반 값으로 자유롭게 연산 가능
let string = "12"
var stringToInt: Int! = Int(string)
print(stringToInt + 1)

let string2 = "u"
var stringToInt2: Int? = Int(string2)
print((stringToInt2 ?? "숫자형 문자가 아님"))






//: [Next](@next)
