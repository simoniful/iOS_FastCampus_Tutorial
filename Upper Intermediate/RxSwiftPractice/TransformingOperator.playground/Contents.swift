import Foundation
import RxSwift

let bag = DisposeBag()

// 각 독립적 엘리먼트가 하나의 어레이로 들어가도록 구성
// Single 처럼 onSuccess/ onFailure 로 구성
print("------toArray------")
Observable.of("A", "B", "C")
    .toArray()
    .subscribe(
        onSuccess: {
            print($0)
        }
    )
    .disposed(by: bag)

// 원하는 형 변환
print("------map------")
Observable.of(Date())
    .map { date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

// 중첩으로 래핑된 Observable의 사용
// Observable<Observable<String>>
print("------flatMap------")
protocol 선수 {
    var 점수: BehaviorSubject<Int> { get }
}

struct 양궁선수 : 선수 {
    var 점수: BehaviorSubject<Int>
}

let 🇰🇷국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 10))
let 🇺🇸국가대표 = 양궁선수(점수: BehaviorSubject<Int>(value: 8))

let 올림픽경기 = PublishSubject<선수>()

올림픽경기
    .flatMap { 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

올림픽경기.onNext(🇰🇷국가대표)
🇰🇷국가대표.점수.onNext(10)

올림픽경기.onNext(🇺🇸국가대표)
🇰🇷국가대표.점수.onNext(10)
🇺🇸국가대표.점수.onNext(9)

// map + switchLatest
// 가장 최근에 Observable에서 값을 생성하고, 그 이전에 발생한 Observable을 구독해제, 가장 최신의 값만을 반영
// 네트워킹 조작에서 가장 흔하게 사용 - "swift"라는 문자열 검색
print("------flatMapLatest------")
struct 높이뛰기선수 : 선수 {
    var 점수: BehaviorSubject<Int>
}

let 서울대표 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 7))
let 부산대표 = 높이뛰기선수(점수: BehaviorSubject<Int>(value: 6))

let 전국체전 = PublishSubject<선수>()

전국체전
    .flatMapLatest { 선수 in
        선수.점수
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

전국체전.onNext(서울대표)
서울대표.점수.onNext(9)

전국체전.onNext(부산대표)
// 현재 부산 시퀀스가 발생한 이 후 서울 시퀀스는 해제되기에 변경된 서울 값에 대해선 무시
서울대표.점수.onNext(10)
부산대표.점수.onNext(8)

// Observble을 Observable Event로 변환 시 사용
// 에러이벤트 처리
print("------materialize & dematerialize------")
enum 반칙: Error {
    case 부정출발
}

struct 달리기선수: 선수 {
    var 점수: BehaviorSubject<Int>
}

let 김토끼 = 달리기선수(점수: BehaviorSubject<Int>(value: 0))
let 박치타 = 달리기선수(점수: BehaviorSubject<Int>(value: 1))

let 달리기대회 = BehaviorSubject<선수>(value: 김토끼)

달리기대회
    .flatMapLatest { 선수 in
        선수.점수
            // 완전종료되지 않고 이벤트와 함께 결과값 도출
            .materialize()
    }
    .filter({
        guard let error = $0.error else { return true }
        print(error)
        return false
    })
    // 다시 이벤트에서 원래 상태로 돌려줌
    .dematerialize()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

김토끼.점수.onNext(1)
김토끼.점수.onError(반칙.부정출발)
// 출력되지 않음 - error를 통해 해당 시퀀스는 종료
김토끼.점수.onNext(2)

달리기대회.onNext(박치타)
박치타.점수.onNext(3)


print("------전화번호 11자리------")
let input = PublishSubject<Int?>()
let list: [Int] = [1]

input
    .flatMap {
        $0 == nil ? Observable.empty() : Observable.just($0)
    }
    .map { $0! }
    .skip(while: { $0 != 0 })
    .take(11)
    .toArray()
    .asObservable()
    .map {
        $0.map { "\($0)" }
    }
    .map { numbers in
        var numberList = numbers
        numberList.insert("-", at: 3)
        numberList.insert("-", at: 8)
        let number = numberList.reduce(" ", +)
        return number
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)


input.onNext(10)
input.onNext(0)
input.onNext(nil)
input.onNext(1)
input.onNext(0)
input.onNext(4)
input.onNext(3)
input.onNext(nil)
input.onNext(1)
input.onNext(8)
input.onNext(9)
input.onNext(4)
input.onNext(9)
input.onNext(1)
