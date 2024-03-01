import UIKit
import RxSwift


let disposedBag = DisposeBag()
// startWith
//Observable.from([1,2,3])
//    .startWith(0)
//    .startWith(-2,-1)
//    .subscribe { print($0) }
//    .disposed(by: disposedBag)

// flatmap
let someObservable1 = Observable.of(1, 2, 3)
let someObservable2 = Observable.of("A", "B", "C")

someObservable1
    .flatMap { num -> Observable<String>  in
        print("방출되는 Num item : \(num)")
        return someObservable2
    }
    .subscribe { print($0)
    }
