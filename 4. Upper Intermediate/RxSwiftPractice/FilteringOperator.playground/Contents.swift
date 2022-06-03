import Foundation
import RxSwift

let bag = DisposeBag()

// 구독 시 onNext 이벤트 모두 무시
print("------ignoreElements------")
let 취침모드😴 = PublishSubject<String>()
취침모드😴
    .ignoreElements()
    .subscribe {
        print("☀️", $0)
    }
    .disposed(by: bag)

취침모드😴.onNext("🔊")
취침모드😴.onNext("🔊")
취침모드😴.onNext("🔊")
취침모드😴.onCompleted()

// 구독 시 원하는 index의 이벤트를 선택적으로 받음
print("------elementAt------")
let 두번울면깨는사람 = PublishSubject<String>()

두번울면깨는사람
    .element(at: 2)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

두번울면깨는사람.onNext("🔊") // index0
두번울면깨는사람.onNext("🔊") // index1
두번울면깨는사람.onNext("🙄") // index2
두번울면깨는사람.onNext("🔊") // index3

// 구독 시 필터링 요구 사항이 1가지 이상일 때 구문 내 작성을 통해서 걸러내는 것이 가능
print("------filter------")
Observable.of(1, 2, 3, 4, 5, 6, 7, 8)
    .filter { $0 % 2 == 0 }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

// 구독 시 특정 갯수의 요소를 무시하는 것이 가능
print("------skip------")
Observable.of("😀", "😃", "😄", "😁", "😎", "🐶")
    .skip(5)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

// 특정 요소가 등장할 때 까지 무시
// false가 되었을 때 부터 방출, filter와 반대
print("------skipWhile------")
Observable.of("😀", "😃", "😄", "😁", "😎", "🐶", "🤩", "🤓", "🥸")
    .skip(while: {
        $0 != "🐶"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

// 다른 옵저버블의 요소의 기반한 다이나믹한 필터링 가능
// 다른 옵저버블이 이벤트를 방출할 때까지 무시
print("------skipUntil------")
let 손님 = PublishSubject<String>()
let 문여는시간 = PublishSubject<String>()

손님
    .skip(until: 문여는시간)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

손님.onNext("😀")
손님.onNext("😃")

문여는시간.onNext("땡!")

손님.onNext("😄")

// 특정 갯수의 방출된 값만 받도록 지정, skip의 반대
print("------take------")
Observable.of("🥇", "🥈", "🥉", "🏅", "🏅")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

// 특정 요소가 등장할 때 까지 방출
// false가 되었을 때 부터 무시
print("------takeWhile------")
Observable.of("🥇", "🥈", "🥉", "🏅", "🏅")
    .take(while: {
        $0 != "🥉"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

// 구독 시 방출된 요소의 인덱스를 참고하고자 할 때 사용
// 튜플 생성
print("------enumerated------")
Observable.of("🥇", "🥈", "🥉", "🏅", "🏅")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

// 다른 옵저버블의 요소의 기반한 다이나믹한 필터링 가능
// 다른 옵저버블이 이벤트를 방출할 때까지 방출
print("------takeUntil------")
let 수강신청 = PublishSubject<String>()
let 신청마감 = PublishSubject<String>()

수강신청
    .take(until: 신청마감)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)

수강신청.onNext("알고리즘")
수강신청.onNext("네트워크")

신청마감.onNext("땡!")

수강신청.onNext("운영체제")

// 앞서 반복된 요소는 무시하고 바뀌는 요소만 방출
print("------distinctUntilChanged------")
Observable.of("저는", "저는", "앵무새", "앵무새", "앵무새", "입니다", "저는", "앵무새", "일까요?", "일까요?", "일까요?")
    .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)
