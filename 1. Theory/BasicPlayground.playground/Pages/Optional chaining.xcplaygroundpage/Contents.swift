//: [Previous](@previous)

import Foundation

// 옵셔널 체이닝
// 옵셔널에 속한 nil의 가능성이 있는 프로퍼티, 메서드, 서브스크립션 등을 가져오거나 호출할 때 사용할 수 있는 일련의 과정
// 내부 프로퍼티 접근 시 바이닝을 대체할 접근 가능
// ? - 항상 옵셔널, ! - 강제 해제

struct Developer {
    var name: String
}

struct Company {
    let name: String
    var developer: Developer?
}

var developer = Developer(name: "Han")
var company = Company(name: "Simon", developer: developer)

print(company.developer)
print(company.developer?.name)
print(company.developer!.name)


//: [Next](@next)
