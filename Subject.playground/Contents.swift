import UIKit
import RxSwift

let disposeBag = DisposeBag()
// 1-1. Cold Observable 🥶
// 구독 되어야만 이벤트를 방출하는 Observable
let coldObservable = Observable<Int>.just(10)
// 여기까지 실행을 해도 Subscribe하지 않기 때문에 이벤트가 방출되지 않는다.
coldObservable.subscribe { num in print(num)}
// 위처럼 Observable을 Subscribe해야 이벤트를 방출한다.

// 1-2. Hot Observable 🥵
// 구독 여부와 상관 없이 이벤트를 방출하는 Observable
let subject = PublishSubject<Int>()
subject.on(.next(10))
// Subscribe하지 않아도 onNext 이벤트를 방출할 수 있다.

// 2-1. Unicast
let someObservable = Observable<Int>.deferred {
    return Observable.just(Int.random(in: 0..<100))
}

someObservable.subscribe { num in
    print("첫번째 Observer(Cold) >> \(num)")
}.disposed(by: disposeBag)

someObservable.subscribe { num in
    print("두번째 Observer(Cold) >> \(num)")
}.disposed(by: disposeBag)

// 2-2. Multicast
subject.subscribe { print("첫번째 Observer(Hot) >> \($0)") }
    .disposed(by: disposeBag)

subject.subscribe { print("두번째 Observer(Hot) >> \($0)") }
    .disposed(by: disposeBag)

subject.onNext(Int.random(in: 0..<100))

// 3-1. PublishSubject
// 구독한 시점 이후에 방출 된 이벤트를 옵저버에게 전달
let somePublishSubject = PublishSubject<Int>()
somePublishSubject.subscribe(onNext: {
    print("첫번째 Observer >> \($0)")
}).disposed(by: disposeBag) // 구독

somePublishSubject.onNext(1) // 이벤트 방출
somePublishSubject.onNext(2) // 이벤트 방출

somePublishSubject.subscribe(onNext: {
    print("두번째 Observer >> \($0)")
}).disposed(by: disposeBag) // 구독

somePublishSubject.onNext(3) // 이벤트 방출

// 3-2. BehaviorSubject
// Observable이 가장 최근에 방출한 항목(아무것도 발행하지 않았다면 초기값)을 한번 방출하며,
// 그 이후부터 Observable에 의해 방출 된 항목들을 Observer에게 전달
let someBehaviorSubject = BehaviorSubject<Int>(value: 1)
someBehaviorSubject.subscribe(onNext: {
    print("첫번째 Observer >> \($0)")
}).disposed(by: disposeBag)

someBehaviorSubject.onNext(2)
someBehaviorSubject.onNext(3)

someBehaviorSubject.subscribe (onNext: {
    print("두번째 Observer >> \($0)")
}).disposed(by: disposeBag)

someBehaviorSubject.onNext(4)

// 3-3. ReplaySubject
// 최신 이벤트를 버퍼 사이즈에 맞게 저장, Observer가 Subscribe 시 Buffer에 있는 이벤트를 모두 전달
let someReplaySubject = ReplaySubject<Int>.create(bufferSize: 3)
someReplaySubject.subscribe(onNext: {
    print("첫번째 Observer >> \($0)")
}).disposed(by: disposeBag)

someReplaySubject.onNext(1)
someReplaySubject.onNext(2)
someReplaySubject.onNext(3)
someReplaySubject.onNext(4)

someReplaySubject.subscribe(onNext: {
    print("두번째 Observer >> \($0)")
}).disposed(by: disposeBag)

// 3-4. AsyncSubject
// Completed 이벤트가 전달되기 전까지 어떠한 이벤트도 방출하지 않는다.
// Completed 이벤트가 전달되면, 가장 최근에 방출된 값을 전달한다.

let someAsyncSubject = AsyncSubject<Int>()
someAsyncSubject.subscribe(onNext: {
    print("첫번째 Observer >> \($0)")
}).disposed(by: disposeBag)

someAsyncSubject.onNext(1)
someAsyncSubject.onNext(2)
someAsyncSubject.onNext(3)
// 아무 것도 출력되지 않는다.

someAsyncSubject.onCompleted()


