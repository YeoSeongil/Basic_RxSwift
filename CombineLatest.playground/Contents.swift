import UIKit
import RxSwift

let disposeBag = DisposeBag()
let left = PublishSubject<String>()
let right = PublishSubject<String>()

//let observable = Observable
//    .combineLatest(left, right) { (lastLeft, lastRight) in
//        "\(lastLeft) \(lastRight)"
//    }


let observable2 = Observable
    .combineLatest(left, right)

observable2.subscribe(onNext: { (left, right) in
    print(left)
    print(right)
}).disposed(by: disposeBag)

left.onNext("Hello")
right.onNext("World")

left.onNext("Hello2")
right.onNext("World2")


