import Foundation

protocol EngineProtocol {
    func start()
}

// 하위 모듈
class Engine: EngineProtocol {
    func start() {
        print("엔진 가동")
    }
}

class ElectricMotor: EngineProtocol {
    func start() {
        print("전기모터 가동")
    }
}

// 상위 모듈
class Car {
    private let engine: EngineProtocol
    
    init(engine: EngineProtocol) {
        self.engine = engine
    }
    
    func start() {
        engine.start()
        print("차가 출발합니다.")
    }
}

let engine = Engine()
let myCar = Car(engine: engine)
myCar.start()

let electricMotor = ElectricMotor()
let myCar2 = Car(engine: electricMotor)
myCar2.start()


