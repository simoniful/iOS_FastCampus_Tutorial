//: [Previous](@previous)

import Foundation

// 프로그래머가 데이터를 용도에 맞에 표현
// 프로퍼티(멤버 변수), 메서드(멤버 함수)로 구조화된 데이터 정의
// 구조체 = 값, 클래스 = 참조
// 별도의 생성자 선언 없이도, 자동으로 구성이 된다

struct User {
    var nick: String
    var age: Int
    
    func information () {
        print("\(nick) \(age)")
    }
}

var user = User(nick: "Simon", age: 32)
user.nick
user.age = 30
user.age
user.information()

//: [Next](@next)
