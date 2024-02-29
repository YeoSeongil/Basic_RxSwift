import UIKit
import RxSwift

let disposeBag = DisposeBag()

// Observer는 Observable을 구독
// Observable이 Emit(방출)하는 하나 또는 연속된 Item에 Observer는 반응을 한다.

// #1 Create 연산을 통해 Observable의 동작을 직접 구현하는 방법
Observable<Int>.create { observer in
    observer.on(.next(5))
    observer.onNext(5)
    // onNext()는 on(.next())의 축약형 = 같은 메소드
    observer.onCompleted()
    return Disposables.create()
}

// # 2 Just 연산을 통해 Observable을 생성하는 방법
Observable<Int>.just(5)
    .subscribe { item in print(item)}
    .disposed(by: disposeBag)

Observable<String>.just("Yeo Seongil")
    .subscribe { item in print(item)}
    .disposed(by: disposeBag)
Observable<[String]>.just(["Yeo", "Kim", "Lee"])
    .subscribe { item in print(item)}
    .disposed(by: disposeBag)

// #3 of 연산을 통해 Observable을 생성하는 방법
Observable<Int>.of(1,2,3,4,5)
    .subscribe { item in print(item)}
    .disposed(by: disposeBag)
Observable<[String]>.of(["Yeo", "Seongil"], ["Yeo", "Seongil2"])
    .subscribe { item in print(item)}
    .disposed(by: disposeBag)

// #4 from 연산을 통해 Observable을 생성하는 방법
Observable<Int>.from([1,2,3,4,5])
    .subscribe { item in print(item) }
    .disposed(by: disposeBag)
Observable<String>.from(["Yeo", "Seongil"])
    .subscribe { item in print(item) }
    .disposed(by: disposeBag)
