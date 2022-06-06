import Foundation
import RxSwift

let disposeBag = DisposeBag()

// MARK: - 시퀀스 Append
// 초기 값을 받는지 여부에 대한 확인 - 현재 위치, 네트워크 연결 상태
// 현재 상태와 함께 초기 값을 붙이기
// startWith는 위치에 상관없이 선언하게 되면 무조건 가장 초기값 선정
// 일종의 concat의 변형
print("------startWith------")
let 노랑반 = Observable<String>.of("👧🏻", "🧒🏽" , "👦🏾")
노랑반
    .enumerated()
    .map { index, element in
        return element + "어린이" + "\(index)"
    }
    .startWith("🧑🏼‍🏫 선생님")
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// concat안에 들어간 시퀀스/컬렉션을 합쳐서 하나의 옵저버블로 구성
print("------concat1------")
let 노랑반어린이들 = Observable<String>.of("👧🏻", "🧒🏽" , "👦🏾")
let 선생님 = Observable<String>.of("🧑🏼‍🏫 선생님")

let 줄서서걷기 = Observable
    .concat([선생님, 노랑반어린이들])

줄서서걷기
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


print("------concat2------")
선생님.concat(노랑반어린이들)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// flatMap, concatMap 차이
// 끼어들기(인터리빙) / 순서의 보장
print("------concatMap------")
let 어린이집: [String: Observable<String>] = [
    "노랑반": Observable.of("👧🏻", "🧒🏽" , "👦🏾"),
    "파랑반": Observable.of("👶🏻", "👶🏽")
]

Observable.of("노랑반", "파랑반")
    .concatMap { 반 in
        어린이집[반] ?? .empty()
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - 시퀀스 합치기
// 순서를 보장하지 않고 합쳐져서 나오게 됨 - 각각 요소가 도착하는대로 방출
// 종료 시점은 전체 옵저버블이 완료 되었을 때
// 둘 중 하나라도 에러를 방출하면 전체를 에러로 간주하고 종료
print("------merge1------")
let 강북 = Observable.of("강북구", "성북구", "동대문구", "마포구", "종로구")
let 강남 = Observable.of("강남구", "강동구", "구로구", "관악구", "양천구", "송파구")
Observable.of(강북, 강남)
    .merge()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// 순서를 보장하는 거로 보이나 maxConcurrent는 한 번에 받아낼 Observable의 수를 제한
// 강북 시퀀스가 완료되기 전까지는 강남 시퀀스를 보지 않게 됨
// 갯수의 제한을 두지 않고 합치는 위의 경우 많이 사용
// 네트워크 요청이 많아질 때 리소스, 연결 수를 제한할 때 사용
print("------merge2------")
Observable.of(강북, 강남)
    .merge(maxConcurrent: 1)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// 여러 텍스트 필드를 한번에 관찰하여 값을 결합하거나
// 여러 소스를 보는 상태에서 사용
// 컴바인 되는 두 옵저버블이 모두 이벤트를 방출해야 결합이 시작
// 각각 시퀀스의 최신의 값을 기준
print("------combineLatest1------")
let 성 = PublishSubject<String>()
let 이름 = PublishSubject<String>()

let 성명 = Observable
    .combineLatest(성, 이름) { 성, 이름 in
        성 + 이름
    }

성명
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

성.onNext("김")
이름.onNext("영수")
이름.onNext("지혜")
이름.onNext("은영")
성.onNext("박")
성.onNext("이")
성.onNext("조")

// 총 8개의 소스를 받아서 결합이 가능
// 각 다른 타입의 결합을 응용하여 사용이 가능
// 원하는 타입으로 리턴
print("------combineLatest2------")
let 날짜표시형식 = Observable<DateFormatter.Style>.of(.short, .long)
let 현재날짜 = Observable<Date>.of(Date())

let 현재날짜표시 = Observable
    .combineLatest(날짜표시형식, 현재날짜) { 형식, 날짜 -> String in
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = 형식
        return dateformatter.string(from: 날짜)
    }

현재날짜표시
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// 콜렉션 타입을 활용해서 묶어서 결합도 가능
print("------combineLatest3------")
let lastName = PublishSubject<String>()
let firstName = PublishSubject<String>()

let fullName = Observable.combineLatest([firstName, lastName]) { name in
    name.joined(separator: " ")
}

fullName
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

lastName.onNext("Smith")
firstName.onNext("Paul")
firstName.onNext("Samuel")
firstName.onNext("Lisa")

// 총 8개의 소스를 받아서 결합이 가능
// 각 순서를 보장하면서 해당 인덱스 요소끼리 결합
// 중국의 경우 출력되지 않는데
// 새 값을 서로가 방출할 때 까지 기다리다가 둘 중 하나의 Observable이 완료되면 zip 전체가 완료
// merge의 경우 갯수가 같지 않더라도 모든 엘리먼트가 나오는 것과 차이
print("------zip------")
enum 승패 {
    case 승
    case 패
}

let 승부 = Observable<승패>.of(.승, .승, .패, .승 ,.패)
let 선수 = Observable<String>.of("🇰🇷", "🇯🇵", "🇺🇸", "🇸🇬", "🇹🇼", "🇨🇳")

let 시합결과 = Observable
    .zip(승부, 선수) { 결과, 대표선수 in
        return 대표선수 + "선수" + "\(결과)"
    }

시합결과
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// MARK: - Trigger

// 총 쏘는 트리거가 있기 전까지 달리기 선수가 방출되지 않음
// 트리거에 onNext로 이벤트가 전달될 경우 방출
// withLatestFrom 안에 들어가는 Observable이 전달되는 역할
// 트리거가 발생된 시점에서 가장 최근의 값을 방출, 이전 값은 무시
print("------withLatestFrom------")
let 💥🔫 = PublishSubject<Void>()
let 달리기선수 = PublishSubject<String>()

💥🔫
    .withLatestFrom(달리기선수)
    // .distinctUntilChanged()
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

달리기선수.onNext("🏃🏻‍♀️")
달리기선수.onNext("🏃🏻‍♀️🏃🏻")
달리기선수.onNext("🏃🏻‍♀️🏃🏻🏃🏻‍♂️")
💥🔫.onNext(Void())
💥🔫.onNext(Void())

// 출발이 여러번 발생해도 가장 마지막 F1 선수의 값만 방출
// withLatestFrom과 비슷하게 작동하지만 단 한 번만 작동하는 차이
// withLatestFrom에서 동일하게 동작하게 하려면 .distinctUntilChanged()를 통해 동일한 동작에 대해 걸러주는 것이 가능
print("------sample------")
let 🏁출발 = PublishSubject<Void>()
let F1선수 = PublishSubject<String>()

F1선수
    .sample(🏁출발)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

F1선수.onNext("🏎")
F1선수.onNext("🚗")
F1선수.onNext("🚙")
🏁출발.onNext(Void())
🏁출발.onNext(Void())
🏁출발.onNext(Void())

// MARK: - Switch
// 모호한 두가지 시퀀스를 받을 때 사용
// 모두 구독하나 지켜보다가 먼저 요소를 방출하는 시퀀스만을 관찰
// 처음에 어떤 시퀀스를 선택해야할지 결정하지 못할 때, 시작하는 걸 보고 결정
print("------amb------")
let 🚌버스1 = PublishSubject<String>()
let 🚌버스2 = PublishSubject<String>()

let 🚏버스정류장 = 🚌버스1.amb(🚌버스2)

🚏버스정류장
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

🚌버스2.onNext("버스2 - 승객0: 👩🏻‍💼")
🚌버스1.onNext("버스1 - 승객0: 👩🏼‍💼")
🚌버스1.onNext("버스1 - 승객1: 🧑🏻‍💼")
🚌버스2.onNext("버스2 - 승객1: 🧑🏼‍💼")
🚌버스1.onNext("버스1 - 승객2: 👨🏻‍💼")
🚌버스2.onNext("버스2 - 승객2: 👨🏼‍💼")

// 손들기와 학생의 여러 이벤트 주입이 있을 때
// switchLatest 연산자의 목적은 손들기라는 Source Observable로 들어온 마지막 최신의 시퀀스의 아이템만 구독
// 들어오지 않은 아이템에 대해선 무시

print("------switchLatest------")
let 👩🏻‍💻학생1 = PublishSubject<String>()
let 🧑🏻‍💻학생2 = PublishSubject<String>()
let 👨🏻‍💻학생3 = PublishSubject<String>()

let 손들기 = PublishSubject<Observable<String>>()

let 손들고말하는교실 = 손들기.switchLatest()

손들고말하는교실
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손들기.onNext(👩🏻‍💻학생1)
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 저는 1번 학생입니다")
🧑🏻‍💻학생2.onNext("🧑🏻‍💻학생2: 저요! 저요!!")

손들기.onNext(🧑🏻‍💻학생2)
🧑🏻‍💻학생2.onNext("🧑🏻‍💻학생2: 저는 2번 학생이에요!")
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 아.. 아직 할 말 있는데")

손들기.onNext(👨🏻‍💻학생3)
🧑🏻‍💻학생2.onNext("🧑🏻‍💻학생2: 아니 잠깐만! 내가!")
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 언제 말할 수 있죠?")
👨🏻‍💻학생3.onNext("👨🏻‍💻학생3: 저는 3번 학생입니다. 아무래도 제가 이긴 거 같네요")

손들기.onNext(👩🏻‍💻학생1)
👩🏻‍💻학생1.onNext("👩🏻‍💻학생1: 아니, 틀렸어! 승자는 나지")
🧑🏻‍💻학생2.onNext("🧑🏻‍💻학생2: ㅠㅠ ")
👨🏻‍💻학생3.onNext("👨🏻‍💻학생3: 이긴 줄 알았는데?")
🧑🏻‍💻학생2.onNext("🧑🏻‍💻학생2: 이거 이기고 지는 손들기였나요?")

// MARK: - 시퀀스 내 요소들간의 결합

// 누산기 역할 - 결과 값만 방출
print("------reduce------")
Observable.from((1...10))
//    .reduce(0, accumulator: { summary, newValue in
//        return summary + newValue
//    })
//    .reduce(0) { summary, newValue in
//        return summary + newValue
//    }
    .reduce(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

// 누산기 역할 - 매번 값이 들어올 때 마다 변형된 결과값들을 방출
print("------scan------")
Observable.from((1...10))
    .scan(0, accumulator: +)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)


