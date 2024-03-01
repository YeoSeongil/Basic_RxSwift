import UIKit
import RxSwift
import RxCocoa

// Relay는 Subject를 wrraping 했기 때문에, 방식은 비슷하다.
// Relay는 Subject와 다르게 Next이벤트만 받고, Completed와 error 이벤트는 받지 않기 때문에, 종료되지 않는다.
// ➡️ 종료 없이 지속되는 UI 이벤트를 처리할 때 사용한다. ( = 따라서 RxCocoa에서 지원한다.)
// Dispose되기 전까지 종료되지 않는다.
// Subject에서는 onNext를 통해 전달하지만, Relay에서는 accept 메소드를 사용하여 전달한다.

// 1-1. PublishRelay
let somePublishRelay = PublishRelay<Int>()
//somePublishRelay.accept(1)
//somePublishRelay.subscribe { print("첫번째 옵저버 >> \($0)") }
//
//somePublishRelay.accept(2)
//somePublishRelay.accept(3)
//
//somePublishRelay.subscribe { print("두번째 옵저버 >> \($0)") }
//somePublishRelay.accept(4)

// 1-2. Behavior Relay
//let someBehaviorRelay = BehaviorRelay<Int>(value: 0)
//someBehaviorRelay.accept(1)
//
//someBehaviorRelay.subscribe { print("첫번째 옵저버 >> \($0)") }
//
//someBehaviorRelay.accept(2)
//someBehaviorRelay.accept(3)
//
//someBehaviorRelay.accept(4)
//print("Value : \(someBehaviorRelay.value)") // output : 4
//
//someBehaviorRelay.subscribe { print("두번째 옵저버 >> \($0)") }

//someBehaviorRelay.accept(5)
//print("Value : \(someBehaviorRelay.value)") // output : 5

// 1-3. ReplayRelay
let someReplayRelay = ReplayRelay<Int>.create(bufferSize: 3)
someReplayRelay.accept(1)
someReplayRelay.accept(2)
someReplayRelay.accept(3)
someReplayRelay.accept(4)

someReplayRelay.subscribe { print("첫번째 옵저버 >> \($0)") } // output : 23456789
someReplayRelay.accept(5)
someReplayRelay.accept(6)
someReplayRelay.accept(7)
someReplayRelay.accept(8)

someReplayRelay.subscribe { print("두번째 옵저버 >> \($0)") } // output : 6789
someReplayRelay.accept(9)
