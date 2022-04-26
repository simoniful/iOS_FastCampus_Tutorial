//: [Previous](@previous)

import Foundation

// 클래스, 구조체, 열거형의 인스턴스를 사용하기 위한 준비 과정
// 인스턴스의 초기화를 담당
// 인스턴스 프로퍼티 마다 초기값 설정, 새 인스턴스 사용 전 필요 설정
// deinit 인스턴스가 메모리에서 해제 될 때 호출

class User {
    var nick: String
    var age: Int
    
    init(nick: String, age: Int) {
        self.nick = nick
        self.age = age
    }
    
    init(age: Int) {
        self.nick = "Albert"
        self.age = age
    }
    
    deinit {
        print("deinit user")
    }
}

var user = User(nick: "Simon", age: 32)
user.nick
user.age

var user2 = User(age: 27)
user2.nick
user2.age

var user3: User? = User(nick: "Janggo", age: 41)
user3 = nil
//: [Next](@next)
