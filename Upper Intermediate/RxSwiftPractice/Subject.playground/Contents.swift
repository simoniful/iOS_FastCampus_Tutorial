import Foundation
import RxSwift

// Subject = Observer이자 Observable
let bag = DisposeBag()

// publishSubject
// 구독한 시점 이전의 이벤트에 대해서는 전혀 받아들이지 못함
// complete 이 후에는 완전 종료 - 구독을 하더라도 이벤트를 받지 못함, completed 만 받음
// dispose의 시점에 따라 이벤트 리스닝의 수동적인 조정이 가능함
print("------publishSubject------")
let publishSubject = PublishSubject<String>()
publishSubject.onNext("1. 안녕하세요")

let subscriber1_1 = publishSubject
    .subscribe(onNext: {
        print("구독자 1)", $0)
    })

publishSubject.onNext("2. 들리세요?")
publishSubject.onNext("3. 안들리시나요?")

subscriber1_1.dispose()

let subscriber1_2 = publishSubject
    .subscribe(onNext: {
        print("구독자 2)", $0)
    })
    
publishSubject.onNext("4. 진짜 안들리시나요?")
publishSubject.onCompleted()
publishSubject.onNext("5. 끝인가요?")

subscriber1_2.dispose()

let subscriber1_3 = publishSubject
    .subscribe {
        print("구독자 3)", $0.element ?? $0)
    }

publishSubject.onNext("6. 정말?")


// 반드시 초기값을 가짐
// 구독 시점 직전에 발생한 이벤트에 대한 리스닝 - 항상 값을 가짐
// value 값을 얻는 것이 가능
print("------behaviorSubject------")
enum SubjectError: Error {
    case error1
}

let behaviorSubject = BehaviorSubject<String>(value: "0. 초기값")
behaviorSubject.onNext("1. 첫 번째 방출")

let subscriber2_1 = behaviorSubject
    .subscribe {
        print("구독자 1)", $0.element ?? $0)
    }
    .disposed(by: bag)
 
// behaviorSubject.onError(SubjectError.error1)

let subscriber2_2 = behaviorSubject
    .subscribe {
        print("구독자 2)", $0.element ?? $0)
    }
    .disposed(by: bag)

let value = try? behaviorSubject.value()
print(value)

// 일종의 메모리 버퍼를 가지고 이전의 이벤트를 저장
// 구독 시점에서 이전의 이벤트를 버퍼 사이즈 만큼 받게 됨
// 완전 종료가 되는 complete, error가 되더라도 이전의 이벤트를 받을 수 있음
// 하지만 dispose 되는 경우에는 메모리 해제이므로 앞 전 이벤트를 받는 건 불가
print("------replaySubject------")
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)

replaySubject.onNext("1. 여러분")
replaySubject.onNext("2. 힘내세요")
replaySubject.onNext("3. 어렵지만")

replaySubject.subscribe {
    print("구독자 1)", $0.element ?? $0)
}
.disposed(by: bag)

replaySubject.subscribe {
    print("구독자 2)", $0.element ?? $0)
}
.disposed(by: bag)

replaySubject.onNext("4. 할 수 있어요")
replaySubject.onError(SubjectError.error1)
replaySubject.dispose()

replaySubject.subscribe {
    print("구독자 3)", $0.element ?? $0)
}
.disposed(by: bag)
