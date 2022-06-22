import Foundation
import UIKit
import PlaygroundSupport
import RxSwift
import RxCocoa


let disposeBag = DisposeBag()

// MARK: - Buffer 연산자 계열

// 버퍼를 통해서 하나의 요소는 받을 수 있도록 replay에 설정한 버퍼의 갯수만큼 받을 수 있도록 구성
// 구독하는 시점 이전에 이벤트를 방출했음에도 불구하고 이벤트를 받음
print("------replay------")
let 인사말 = PublishSubject<String>()
let 반복하는앵무새 = 인사말.replay(2)
반복하는앵무새.connect()

인사말.onNext("1: Hello!")
인사말.onNext("2: Is there?")

반복하는앵무새
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

인사말.onNext("3: Anybody here?")

// 시점 이전에 발생한 이벤트에 대해서 갯수 제한없이 받는 것이 가능
print("------replayAll------")
let 닥터스트레인지 = PublishSubject<String>()
let 타임스톤 = 닥터스트레인지.replayAll()
타임스톤.connect()

닥터스트레인지.onNext("도르마무")
닥터스트레인지.onNext("거래를 하러왔다")
닥터스트레인지.onNext("🌌")

타임스톤
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// buffer 항상 array 방출
// source는 시퀀스를 이루는데, MaxCount를 통해서 많아야 지정한 갯수만큼의 요소를 가질 수 있음
// 만약 요소들이 timeSpan이 만료되기 전에 받아졌다면 일단 받아진 만큼만 방출
// 소스에서 받을 것이 없으면 일정 간격으로 빈 어레이 방출
//print("------buffer------")
//let source = PublishSubject<String>()
//var count = 0
//let timer = DispatchSource.makeTimerSource()
//timer.schedule(deadline: .now() + 2, repeating: .seconds(1))
//timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//
//source
//    .buffer(
//        timeSpan: .seconds(2),
//        count: 2,
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

// window 항상 Observable 방출
// buffer와 유사
// 요소가 방출되는 이벤트의 간격과 설정한 시간과 수에 맞춰서 다수의 Observable을 생성
//print("------window------")
//let 만들어낼최대Observable수 = 5
//let 만들시간 = RxTimeInterval.seconds(2)
//
//let window = PublishSubject<String>()
//
//var windowCount = 0
//let windowTimerSource = DispatchSource.makeTimerSource()
//windowTimerSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//windowTimerSource.setEventHandler {
//    windowCount += 1
//    window.onNext("\(windowCount)")
//}
//windowTimerSource.resume()
//
//window
//    .window(
//        timeSpan: 만들시간,
//        count: 만들어낼최대Observable수,
//        scheduler: MainScheduler.instance
//    )
//    .flatMap { windowObservable -> Observable<(index: Int, element: String)> in
//        return windowObservable.enumerated()
//    }
//    .subscribe(onNext: {
//        print("\($0.index)번째 Observable의 요소 \($0.element)")
//    })
//    .disposed(by: disposeBag)


// MARK: - 시간 지연
// 특정 시점이 지난 다음부터 구독 지연 시작
// delay와 비슷하지만, 구독 자체를 늦게하여, 들어오는 이벤트도 알 수 없음
//print("------delaySubscription------")
//let delaySource = PublishSubject<String>()
//
//var delayCount = 0
//let delayTimerSource = DispatchSource.makeTimerSource()
//delayTimerSource.schedule(deadline: .now(), repeating: .seconds(1))
//delayTimerSource.setEventHandler {
//    delayCount += 1
//    delaySource.onNext("\(delayCount)")
//}
//delayTimerSource.resume()
//
//delaySource
//    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

// 전체 시퀀스를 뒤로 미루는 작용 - 구독은 있으나 방출을 뒤로 미루는 것
// 시퀀스의 시작 시점을 아예 뒤로 미루는 것
// 즉, 구독 시점 이후 이벤트가 들어오면 모두 알고 있다가 요소를 방출하는 것을 지연시간 후에 보내.
// 이게 구독을 아예 지연시키는 거랑 차이가 있음
//print("------delay------")
//let delaySubject = PublishSubject<Int>()
//
//var delayCount = 0
//let delayTimerSource = DispatchSource.makeTimerSource()
//delayTimerSource.schedule(deadline: .now(), repeating: .seconds(1))
//delayTimerSource.setEventHandler {
//    delayCount += 1
//    delaySubject.onNext(delayCount)
//}
//delayTimerSource.resume()
//
//delaySubject
//    .delay(.seconds(6), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

// MARK: - DispatchSource 타이머 구성 대체, 직관성 향상
// 특정 간격으로 생성 설정
//print("------interval------")
//Observable<Int>
//    .interval(.seconds(3), scheduler: MainScheduler.instance)
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

// interval과 유사
// 구독하고 첫 번째 값을 방출하는 거 사이에 dueTime 설정 가능 - 딜레이 값
// 반복할 수 있는 기간이 옵셔널로 설정 가능
//print("------timer------")
//Observable<Int>
//    .timer(
//        .seconds(5),
//        period: .seconds(2) ,
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)


// 정한 시간 내에 어떠한 이벤트도 발생시키지 않으면 error 발생
print("------timeout------")
let 누르지않으면에러 = UIButton(type: .system)
누르지않으면에러.setTitle("눌러주세요", for: .normal)
누르지않으면에러.sizeToFit()

PlaygroundPage.current.liveView = 누르지않으면에러

누르지않으면에러.rx.tap
    .do(onNext: {
        print("tap")
    })
    .timeout(.seconds(7), scheduler: MainScheduler.instance)
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
 

