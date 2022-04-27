//: [Previous](@previous)

import Foundation

/*
 공통점
 1. 값을 저장할 프로퍼티 선언
 2. 함수적 기능을 하는 메서드 선언
 3. 내부 값에 dot notation을 통한 접근
 4. 생성자를 통한 초기 상태 설정
 5. extension을 통한 기능 확장
 6. Protocol 채택 기능 설정
 */

/*
 차이점
 * Class
 참조 타입, 메모리 스택 영역에 포인터(메모리 주소)만 할당 - 실제 데이터는 힙 영역에 할당
 ARC로 메모리 관리 - deinit을 통한 해제 가능
 상속 가능
 타입 캐스팅을 통한 런타임 환경에서 클래스 인스턴스의 타입 확인 가능
 같은 클래스 인스턴스를 여러 개의 변수에 할당한 뒤 값을 변경하면 모든 변수에 영향 - 메모리 주소 복사
 
 * 구조체
 값 타입,메모리 스택 영역에 값으로 저장
 ARC로 메모리 관리 X
 같은 구조체 인스턴스를 여러 개의 변수에 할당한 뒤 값을 변경하더라도 다른 변수에 영향 X - 값 복사
 상속 불가
 */

class SomeClass {
    var count: Int = 0
}

struct SomeStruct {
    var count: Int = 0
}

var classOne = SomeClass()
var classTwo = classOne
var classThree = classOne

classThree.count = 2
classOne.count

var structOne = SomeStruct()
var structTwo = structOne
var structThree = structOne

structTwo.count = 3
structThree.count = 4

structOne.count
structTwo.count
structThree.count
    
//: [Next](@next)
