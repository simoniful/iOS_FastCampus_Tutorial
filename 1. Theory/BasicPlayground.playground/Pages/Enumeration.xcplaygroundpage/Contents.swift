//: [Previous](@previous)

import Foundation

// 열거형
// 연관성 있는 값을 모아 놓은 것
// 스위프트는 다양한 타입의 원시값을 가지는 것이 가능

enum CompassPoint: String {
    case north = "N"
    case south = "S"
    case east = "E"
    case west = "W"
}

var direction = CompassPoint.east
direction = .south

switch direction {
case .north:
    print(direction.rawValue)
case .south:
    print(direction.rawValue)
case .east:
    print(direction.rawValue)
case .west:
    print(direction.rawValue)
}

let direction2 = CompassPoint(rawValue: "N")
direction2

// 연관 값을 가지는 것이 가능
enum PhoneError {
    case unknown
    case batteryLow(String)
    case thread
}

let error = PhoneError.batteryLow("배터리가 곧 방전됩니다")

switch error {
case .batteryLow(let message):
    print(message)
case .unknown:
    print("알 수 없는 에러 입니다")
case .thread:
    print("메모리 충돌")
}

//: [Next](@next)
