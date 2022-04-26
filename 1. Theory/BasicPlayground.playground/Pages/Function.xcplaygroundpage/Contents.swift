//: [Previous](@previous)

import Foundation

// 반복적 수행 피하기
// 작업 수행의 가장 작은 단위

func sum(_ a: Int, _ b: Int) -> Int {
    return a + b
}

sum(5, 3)

func hello() -> String {
    return "hello"
}

hello()

func printName() -> Void { }

func greeting(friend: String, me: String = "simon") {
    print("Hello, \(friend)! I'm \(me)")
    
}

greeting(friend: "jason")

/*
func 함수 이름(전달인자 레이블: 매개변수 이름: 매개변수 타입, 전달인자 레이블: 매개변수 이름: 매개변수 타입... ) -> 반환 타입 {
    return 반환 값
}
*/

func sendMessage(from myName: String, to name: String) -> String {
    return "Hello, \(name)! I'm \(myName)"
}

sendMessage(from: "Rui", to: "simon")

func sendMessage(_ name: String) -> String {
    return "Hello, \(name)!"
}

sendMessage("이상훈")

// 가변 매개변수
func sendMessage(friends: String... , me: String) {
    print("Hello, \(friends)! I'm \(me)")
}

sendMessage(friends: "Json", "Mario", "Kim", me: "simon")

// 1급 객체 - 변수/상수 할당, 매개변수를 통해 전달도 가능 

//: [Next](@next)
