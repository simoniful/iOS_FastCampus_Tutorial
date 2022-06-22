//: [Previous](@previous)

import Foundation

// 익스텐션으로 새로운 기능을 타입에 추가 가능
// 연산 타입 / 연산 인스턴스 프로퍼티 - 저장 프로퍼티, 프로퍼티 감시자 추가 불가
// 타입 메서드 / 인스턴스 매서드
// 이니셜라이저
// 서브스크립트
// 중첩 타입
// 특정 프로토콜을 준수할 수 있도록 기능 추가

extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    
    var isOdd: Bool {
        return self % 2 == 1
    }
}

3.isOdd
3.isEven

extension String {
    func convertToInt() -> Int? {
        return Int(self)
    }
}

"가".convertToInt()
"1".convertToInt()



//: [Next](@next)
