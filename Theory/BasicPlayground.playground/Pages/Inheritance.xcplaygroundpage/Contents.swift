//: [Previous](@previous)

import Foundation

// child class가 다른 super class로 부터 메서드, 프로퍼티, 서브스크립트를 상속
// 오버라이드로 재정의 가능
// 프로퍼티 감시자를 통해서 부모 쪽을 활용하는 것도 가능

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        print("Speak on")
    }
}


class Bicycle: Vehicle {
    var hasBasket = false
    
    override func makeNoise() {
        super.makeNoise()
        print("Brrrrrr")
    }
    
    
}

let kawasaki = Bicycle()
kawasaki.currentSpeed
kawasaki.currentSpeed = 30.0
kawasaki.description
kawasaki.makeNoise()

// 프로퍼티 재정의 가능
// 계산, 저장 프로퍼티를 오버라이드한 프로퍼티는 setter getter를 가질 수 있음
// 자식 클래스에서 재정의 하려는 프로퍼티는 부모와 이름 타입 일치
// 부모에서 read, write 정의 되었으면, 자식에서 read-only 불가
// 부모에서 read-only 정의 되었으면, 자식에서 read, write 오버라이드 가능

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}

let car = Car()
car.currentSpeed = 30.0
car.gear = 2
car.description

// 상속된 프로퍼티를 오버라이드해서 프로퍼티 옵저버 추가 가능
// 상수 및 read-only는 프로퍼티 옵저버 추가 불가 - 값을 설정하는 것이 불가능하기 때문
// 부모에서 특정 메서드, 프로퍼티에 final 키워드를 붙이게 되면 오버라이드(재정의) 불가
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("Automatic Car: \(automatic.description)")

//: [Next](@next)
