//: [Previous](@previous)

import Foundation

// 고차함수
// 다른 함수를 전달인자로 받거나 함수 실행의 결과를 함수로 반환하는 함수

let numbers = [0, 1, 2, 3]
let mapArray = numbers.map { (number) -> Int in
    return number * 2
}
print("map \(mapArray)")

let numbers2 = [10, 5, 20, 13, 4]
let filterArray = numbers2.filter {
    $0 > 6
}
print("filter \(filterArray)")

let numbers3 = [1, 2, 3, 4, 5]
let reduceResult = numbers3.reduce(0) { (result: Int, element: Int) -> Int in
    print("\(result) + \(element)")
    return result + element
}
print("reduce \(reduceResult)")

//: [Next](@next)
