//: [Previous](@previous)

import Foundation
// 구조체와 유사하지만 생성자 함수를 정의 해야함

class Dog {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func introduce() {
        print("name: \(name), age: \(age)")
    }
}

var dog = Dog(name: "Simba", age: 3)
dog.age = 5
dog.age
dog.name = "Coco"
dog.name
dog.introduce()


//: [Next](@next)
