//: [Previous](@previous)

import Foundation

// assert: 특정 조건을 체크하고 조건이 성립되지 않으면 메세지를 출력하게 하는 함수
// 디버깅 모드에서만 동작하고 주로 디버깅 중 조건의 검증을 목적으로 사용

// guard: 뭔가를 검사하여 그 다음에 오는 코드를 실행여부를 결정
// 주어진 조건문이 거짓일 때 구문이 실행
// 함수 안에서 잘못된 값이 들어오는 걸 방지, 조건문 범위 밖에서도 옵셔널 바인딩 하여 사용 가능

//var value = 0
//assert(value == 0)
//
//value = 2
//assert(value == 0, "값이 0이 아닙니다.")

func guardTest(value: Int?) {
    guard let value = value else { return }
    print("guardTest: \(value)")
}

guardTest(value: nil)


//: [Next](@next)
