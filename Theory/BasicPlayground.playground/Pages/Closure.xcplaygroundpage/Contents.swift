//: [Previous](@previous)

import Foundation

// 클로저 - 익명함수
// 참조 타입
// 코드에서 전달 및 사용할 수 있는 독립 기능 블록 {}
// 상수, 변수 저장, 인자 전달, 함수 반환 값 가능 - 일급 객체
// {클로저 헤드(인자, 반환 타입) in 클로저 바디}

let hello = { () -> () in
    print("Hello")
}

hello()

// 전달 인자 레이블은 사용 X, 오직 파라미터 네임만 가능
let hello2 = { (name: String) -> String in
    return "Hello, \(name)"
}

hello2("Simon")

// 클로저를 함수의 파라미터로 전달
func doSomething(closure: () -> ()) {
    closure()
}

doSomething(closure: { () -> () in
    print("Hello, doSomething")
})

// 함수 반환 타입으로 클로저
func doSomethingReturn() -> () -> () {
    return { () -> () in
        print("Hello, return doSomething")
    }
}

doSomethingReturn()()

// 가독성 향상 - 후행 클로저
doSomething() {
    print("후행 클로저로 실행 테스트")
}

// 다중 후행 클로저
func requestSomething(success: () -> (), fail: () -> ()) { }

requestSomething {
    print("success")
} fail: {
    print("fail")
}

// 클로저 내 매개변수 경량 문법화 가능 - 가독성
// 파라미터 - $0, $1, $2로 넘겨지는
// 리턴 - 키워드 생략
func closureShort(closure: (Int, Int, Int) -> Int) {
    closure(1,2,3)
}

closureShort(closure: { (a, b, c) in
    return a + b + c
})

closureShort(closure: {
    return $0 + $1 + $2
})

closureShort(closure: {
    $0 + $1 + $2
})

closureShort() {
    $0 + $1 + $2
}

closureShort {
    $0 + $1 + $2
}

// 이스케이프 클로저와 순환 참조의 개념 참고

//: [Next](@next)
