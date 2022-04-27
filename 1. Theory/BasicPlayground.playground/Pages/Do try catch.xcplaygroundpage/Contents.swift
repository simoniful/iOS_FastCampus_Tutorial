//: [Previous](@previous)

import Foundation

// 발생(throwing) 감지(catching) 전파(propagating) 조작(manipulating)
// 스위프트 내 error - error 프로토콜을 따르는 타입의 값
// error 프로토콜: 요구 사항이 없는 빈 프로토콜
// 오류 표현을 위해 해당 프로토콜 채택
// 스위프트 열거형은 오류 원인을 나누고 해당 오류의 특성에 대한 추가정보를 전달하는 모델을 만드는데 적합

enum PhoneError: Error {
    case unknown
    case batteryLow(batteryLevel: Int)
}

// throw PhoneError.batteryLow(batteryLevel: 15)

// 1. 함수에서 발생한 오류를 해당 함수를 호출한 코드에 전파
func checkPhoneBatteryStatus(batteryLevel: Int) throws -> String {
    guard batteryLevel != -1 else { throw PhoneError.unknown }
    guard batteryLevel > 20 else { throw PhoneError.batteryLow(batteryLevel: 20) }
    return "배터리 상태가 정상입니다"
}

// 2. do try catch
do {
    try checkPhoneBatteryStatus(batteryLevel: 20)
} catch PhoneError.unknown {
    print("알 수 없는 에러입니다")
} catch PhoneError.batteryLow(let batteryLavel) {
    print("배터리 전원 부족 남은 배터리: \(batteryLavel) 이하")
} catch {
    print("그 외 오류 발생: \(error)")
}

// 3. optional 값으로 처리 try?
let status = try? checkPhoneBatteryStatus(batteryLevel: -1)
print(status)

// 4. 오류가 발생하지 않을 걸 확신 try! - 런타임 에러 주의
let status2 = try! checkPhoneBatteryStatus(batteryLevel: -1)
print(status2)

//: [Next](@next)
