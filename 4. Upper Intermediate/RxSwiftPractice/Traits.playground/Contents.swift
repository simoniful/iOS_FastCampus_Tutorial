import Foundation
import RxSwift

// Traits를 사용하는 이유: 가독성 향상, 직관적, 명시적

enum TraitsError: Error {
    case single
    case maybe
    case completable
}

let bag = DisposeBag()

// Single
// success(next + complete) / error
// 값을 산출하는 비동기적 연산 - ex. 사진 데이터 다운로드의 상황
// 네트워크 환경에서 많이 사용
// 정확히 하나의 요소 또는 error를 방출
// Single() / asSingle() 활용
print("------Single1------")
Single<String>.just("✅")
    .subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: {
            print("Error: \($0)")
        },
        onDisposed: {
            print("disposed")
        }
    )
    .disposed(by: bag)

print("------Single2------")
Observable<String>.create{ observer -> Disposable in
        observer.onError(TraitsError.single)
        return Disposables.create()
    }
    .asSingle()
    .subscribe(
        onSuccess: {
            print($0)
        },
        onFailure: {
            print("Error: \($0)")
        },
        onDisposed: {
            print("disposed")
        }
    )
    .disposed(by: bag)

print("------Single3------")
struct SomeJSON: Decodable {
    let name: String
}

enum JSONError: Error {
    case decodingError
}

let json1 = """
    {"name": "park"}
    """

let json2 = """
    {"my_name": "lee"}
    """

func decode(json: String) -> Single<SomeJSON> {
    Single<SomeJSON>.create { observer -> Disposable in
        guard let data = json.data(using: .utf8),
              let json = try? JSONDecoder().decode(SomeJSON.self, from: data) else {
            observer(.failure(JSONError.decodingError))
            return Disposables.create()
        }
        observer(.success(json))
        return Disposables.create()
    }
}

decode(json: json1)
    .subscribe {
        switch $0 {
        case .success(let json):
            print(json.name)
        case .failure(let error):
            print(error)
        }
    }
    .disposed(by: bag)

decode(json: json2)
    .subscribe {
        switch $0 {
        case .success(let json):
            print(json.name)
        case .failure(let error):
            print(error)
        }
    }
    .disposed(by: bag)

// Maybe
// 완료된 이벤트, 싱글 이벤트 또는 오류를 방출
// 생각보다 많이 사용은 되지 않을 듯
// asMaybe() 활용
print("------Maybe1------")
Maybe<String>.just("✅")
    .subscribe(
        onSuccess: { print($0) },
        onError: { print("Error: \($0)") },
        onCompleted: { print("completed") },
        onDisposed: { print("disposed") }
    )
    .disposed(by: bag)

print("------Maybe2------")
Observable<String>.create{ observer -> Disposable in
        observer.onError(TraitsError.maybe)
        return Disposables.create()
    }
    .asMaybe()
    .subscribe(
        onSuccess: { print($0) },
        onError: { print("Error: \($0)") },
        onCompleted: { print("completed") },
        onDisposed: { print("disposed") }
    )
    .disposed(by: bag)

// Completable
// complete 하거나, error 를 방출
// 아무 요소도 방출하지 않음
// asCompletable() X, Create를 이용하여 생성
// 완료의 여부만 확인하고자 할 때 사용

print("------Completable1------")
Completable.create { observer -> Disposable in
    observer(.error(TraitsError.completable))
    return Disposables.create()
}
.subscribe(
    onCompleted: {  print("completed") },
    onError: { print("Error: \($0)") },
    onDisposed: { print("disposed") }
)
.disposed(by: bag)

print("------Completable2------")
Completable.create { observer -> Disposable in
    observer(.completed)
    return Disposables.create()
}
.subscribe(
    onCompleted: {  print("completed") },
    onError: { print("Error: \($0)") },
    onDisposed: { print("disposed") }
)
.disposed(by: bag)
