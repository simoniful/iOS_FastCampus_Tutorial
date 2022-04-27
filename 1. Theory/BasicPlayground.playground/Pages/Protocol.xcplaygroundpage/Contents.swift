//: [Previous](@previous)

import Foundation

// 구조체, 클래스, 열거형의 메서드, 프로퍼티 등의 청사진


// 상속 클래스 우선 먼저 적고, 이 후 프로토콜
protocol SomeProtocol { }
protocol SomeProtocol2 { }
struct SomeStruct: SomeProtocol, SomeProtocol2  { }
class SomeSuperClass { }
class SomeClass: SomeSuperClass, SomeProtocol, SomeProtocol2 { }

// 프로퍼티는 var로 선언 - 이름, 타입만 선언
// 읽기 / 읽기쓰기
protocol First {
    var name: String { get set }
    var age: Int { get }
}

// 프로토콜에서 타입 프로퍼티를 요구하려면 항상 static 키워드 사용
protocol Another {
    static var someTypeProperty: Int { get set }
}

// 요구 사항 정의
protocol FullyNames {
    var fullName: String { get set }
    func printFullName()
}

// 요구 채택
struct Person: FullyNames {
    var fullName: String
    func printFullName() {
        print(fullName)
    }
}

// 자신을 택한 타입의 생성자도 요구 가능
protocol InitializeSome {
    init()
}

// class에서 해당 프로토콜을 준수하려면 init에 required 식별자 필수, 상속할 수 없는 final의 경우는 불필수
// struct의 경우 필요 없음 - 기본적으로 내장 init
class SomeInitClass: InitializeSome {
    required init() {
        
    }
}

struct SomeInitStruct: InitializeSome {
    
}


//: [Next](@next)
