//: [Previous](@previous)

import Foundation

// 클래스, 구조체, 열거형 등에 관련된 값, 인스턴스의 소속된 변수 및 속성
// 저장 - 변수, 상수
// 연산 - 특정 연산을 실행
// 타입 - 특정 인스턴스가 아닌 특정 타입에서 사용

// 저장 프로퍼티 - 클래스 구조체
enum Gender: Int {
    case male = 0
    case female = 1
}

struct Dog {
    var name: String
    let gender: Gender
}

// 내부 상수 프로퍼티 변경 불가
var dog = Dog(name: "Sizzle", gender: .male)
dog.name = "Zissle"

// struct는 값 타입이라 let으로 선언시 내부 변수 프로퍼티 변경 불가
let dog2 = Dog(name: "Jizzle", gender: .female)

class Cat {
    var name: String
    let gender: Gender
    
    init(name: String, gender: Gender) {
        self.name = name
        self.gender = gender
    }
}

// class는 참조 타입이라 let으로 선언시 내부 변수 프로퍼티 변경 가능
let cat = Cat(name: "Sizzle", gender: .male)
cat.name = "Zissle"

// 계산 프로퍼티 - 클래스 구조체 열거형
// 값을 직접적으로 저장X, getter, setter
// 내 외부의 값을 연산하여 적절한 값을 돌려주는 접근자
// 내부의 프로퍼티의 값을 간접적으로 설정하는 설정자
// get만 선언하여 읽기 전용 프로퍼티도 가능

struct Stock {
    var aver: Int
    var quantity: Int
    var purchasePrice: Int {
        get {
            return aver * quantity
        }
        set(newPrice) {
            aver = newPrice / quantity
        }
    }
}

var stock = Stock(aver: 2300, quantity: 3)
// get
stock.purchasePrice
// set
stock.purchasePrice = 3000
stock

// 프로퍼티 옵저버 - 저장 프로퍼티 + 오버라이딩 된 저장 연산 프로퍼티 사용 가능

class Account {
    var credit: Int = 0 {
        willSet {
            print("잔액 \(credit)에서 \(newValue)로 변경 예정")
        }
        
        didSet {
            print("잔액 \(oldValue)에서 \(credit)로 변경 완료")
        }
    }
}

var account = Account()
account.credit = 3000

// 타입 프로퍼티 - 인스턴스 생성 없이 객체 내 프로퍼티 접근 가능
// 저장 프로퍼티 + 오버라이딩 된 저장 연산 프로퍼티 사용 가능
// static 키워드
// 값 변경도 가능

struct SomeStructure {
    static var storedTypeProperty = "Some value"
    // get-only
    static var computedTypeProperty: Int {
        return 1
    }
}

SomeStructure.storedTypeProperty = "Hello"
SomeStructure.computedTypeProperty


//: [Next](@next)
