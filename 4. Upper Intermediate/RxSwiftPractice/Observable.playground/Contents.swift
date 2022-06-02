import Foundation
import RxSwift

// 구독을 통한 확인이 있기 전까지는 Observable은 정적인 상태, 아무런 역할도 하지 않음 - Trigger

print("------Just------")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

// 여러 요소들이 순차적으로 방출
print("------Of1------")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })

// 하나의 배열인 엘리먼트 1개 방출
print("------Of2------")
Observable.of([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

// 배열 형태의 엘리먼트를 하나씩 방출
print("------From------")
Observable.from([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

// 이벤트 자체를 방출 - onNext, onError, onCompleted 등으로 구분하여 요소 컨트롤 가능
print("------subscribe1------")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }

// onNext와 동일한 구성
print("------subscribe2------")
Observable.of(1, 2, 3)
    .subscribe {
        if let element = $0.element {
            print(element)
        }
    }

print("------subscribe3------")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })

// 아무런 next 이벤트 방출X - 즉시 완전 종료에 대한 리턴, 의도적인 0개의 값을 가지는 Observable
// completed 만 방출
print("------empty------")
Observable<Void>.empty()
    .subscribe {
        print($0)
    }

Observable<Void>.empty()
    .subscribe(onNext: {
        
    }, onCompleted: {
        print("completed")
    })

// 아무런 이벤트 방출X - 즉시 완전 종료에 대한 리턴, 의도적인 0개의 값을 가지는 Observable
print("------never------")
Observable<Void>.never()
    .debug("never")
    .subscribe(
        onNext: {
            print($0)
        },
        onCompleted: {
            print("completed")
        }
    )

print("------range------")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2 * \($0) = \(2 * $0)")
    })


// 수동적인 종료 필요 - 순환 참조 및 메모리 누수 관련 정리 - Dispose
// 무한한 요소로 관찰할 경우 반드시 필요
// 요소가 갯수가 제한적인 경우에는 자동으로 complete 처리
print("------dispose------")
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .dispose()

// 일일이 하나씩 관리가 아닌 일괄적인 관리가 가능하도록 DisposeBag 제공
// 가지고 있다가 자신이 할당 해제 할 때 마다 생명주기에 맞게 모든 구독에 대해서 dispose
print("------disposeBag------")
let bag = DisposeBag()
Observable.of(1, 2, 3)
    .subscribe {
        print($0)
    }
    .disposed(by: bag)

// escaping 클로저로 구성
// 2번째 엘리먼트 방출 x - 종료 이후에는 이벤트 방출 x
// Observer를 이용하여 Observable 시퀀스를 만드는 작업
print("------create1------")
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.on(.next(2))
    observer.onCompleted()
    observer.on(.completed)
    observer.onNext(3)
    return Disposables.create()
}
.subscribe {
    print($0)
}
.disposed(by: bag)

// error 단에서 종료 이후 complete 이벤트는 발생하지 않음
// 메모리 누수 방지를 위해서 이벤트 완전 종료 및 dispose 확인 필요
print("------create2------")
enum MyError: Error {
    case anError
}
Observable.create { observer -> Disposable in
    observer.onNext(1)
    observer.onError(MyError.anError)
    observer.onCompleted()
    observer.onNext(2)
    return Disposables.create()
}
.subscribe(
    onNext: {
        print($0)
    },
    onError: {
        print($0.localizedDescription)
    },
    onCompleted: {
        print("completed")
    },
    onDisposed: {
        print("disposed")
    }
)
.disposed(by: bag)

// Observable을 통하여 Observable 팩토리를 구성
// 실제 구독이 일어나는 시점에서야 실제 Observable을 만들어 냄
// 실제 Observable이 만들어지는 시점이 미루어진다고 해서 ‘deferred’
// 상태에 따라 다른 데이터를 처리해야할 필요가 있을 경우
print("------deffered1------")
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe {
    print($0)
}
.disposed(by: bag)

print("------deffered2------")
var 뒤집기: Bool = false
let factory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("👍")
    } else {
        return Observable.of("👎")
    }
}
for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
    .disposed(by: bag)
}
