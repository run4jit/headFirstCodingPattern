import UIKit

var str = "Hello, Strategy Pattern"
/**
 Strategy Pattern
 */

protocol FlyingBehavior {
    func fly()
}

class FlyWithWing: FlyingBehavior {
    func fly() {
        debugPrint("I can fly with wings.")
    }
}

class FlyNoWay: FlyingBehavior {
    func fly() {
        // Do nothing - Can't fly
        debugPrint("I can not fly.")
    }
}

class FlyWithRoketjet: FlyingBehavior {
    func fly() {
        debugPrint("I can fly with roket speed.")
    }
}

protocol QuackBehavior {
    func quack()
}

class Quack: QuackBehavior {
    func quack() {
        debugPrint("I can Quack.")
    }
}

class Squeak: QuackBehavior {
    func quack() {
        debugPrint("I can Squeak.")
    }
}

class MuteQuack: QuackBehavior {
    func quack() {
        // Do nothing - Can't quack
        debugPrint("I can not quack or squeak.")
    }
}

protocol DuckProtocol {
    var quackBehavior: QuackBehavior { get }
    var flyBehavior: FlyingBehavior { get }
    init(quackBehavior: QuackBehavior, flyBehavior: FlyingBehavior)
    func swim()
    func display()
    func performFly()
    func performQuack()
}

extension DuckProtocol {
    func swim() {
        debugPrint("I can swim.")
    }
}
// ReadHeadDuck, RuberDuck, DecoyDuck
class MallardDuck: DuckProtocol {
    
    let quackBehavior: QuackBehavior
    let flyBehavior: FlyingBehavior

    required init(quackBehavior: QuackBehavior, flyBehavior: FlyingBehavior) {
        self.flyBehavior = flyBehavior
        self.quackBehavior = quackBehavior
    }
    
    func performFly() {
        flyBehavior.fly()
    }
    
    func performQuack() {
        quackBehavior.quack()
    }

//    func fly() {
//        debugPrint("I am flying.")
//    }
//
//    func quack() {
//        debugPrint("I am quacking.")
//    }
    
    func display() {
        debugPrint("I am Mallard duck.")
    }
    
//    func swim() {
//        debugPrint("Mallard duck swiming.")
//    }
}

class RedHeadDuck: DuckProtocol {
    var quackBehavior: QuackBehavior
    
    var flyBehavior: FlyingBehavior
    
    required init(quackBehavior: QuackBehavior, flyBehavior: FlyingBehavior) {
        self.quackBehavior = quackBehavior
        self.flyBehavior = flyBehavior
    }
    
    func display() {
        debugPrint("I am Red head duck.")
    }
    
    func performFly() {
        self.flyBehavior.fly()
    }
    
    func performQuack() {
        self.quackBehavior.quack()
    }
}

class RocketJetDuck: DuckProtocol {
    var quackBehavior: QuackBehavior
    
    var flyBehavior: FlyingBehavior
    
    required init(quackBehavior: QuackBehavior, flyBehavior: FlyingBehavior) {
        self.quackBehavior = quackBehavior
        self.flyBehavior = flyBehavior
    }
    
    func display() {
        debugPrint("I am Roket Jet duck.")
    }
    
    func performFly() {
        self.flyBehavior.fly()
    }
    
    func performQuack() {
        self.quackBehavior.quack()
    }
}

class DecoyDuck: DuckProtocol {
    var quackBehavior: QuackBehavior
    
    var flyBehavior: FlyingBehavior
    
    required init(quackBehavior: QuackBehavior, flyBehavior: FlyingBehavior) {
        self.quackBehavior = quackBehavior
        self.flyBehavior = flyBehavior
    }
    
    func display() {
        debugPrint("I am Decoy duck.")
    }
    
    func performFly() {
        self.flyBehavior.fly()
    }
    
    func performQuack() {
        self.quackBehavior.quack()
    }
}

class DummyDuck: DuckProtocol {
    var quackBehavior: QuackBehavior
    
    var flyBehavior: FlyingBehavior
    
    required init(quackBehavior: QuackBehavior, flyBehavior: FlyingBehavior) {
        self.quackBehavior = quackBehavior
        self.flyBehavior = flyBehavior
    }
    
    func display() {
        debugPrint("I am Dummy duck.")
    }
    
    func performFly() {
        self.flyBehavior.fly()
    }
    
    func performQuack() {
        self.quackBehavior.quack()
    }
}


enum DuckType: CustomStringConvertible {
    case dummy, decoy, rocketJet, redHead, mallard
    
    
    var description: String {
        var duckName: String
        switch self {
        case .dummy: duckName = "Dummy"
        case .decoy: duckName = "Decoy"
        case .rocketJet: duckName = "Rocket Jet"
        case .redHead: duckName = "Red Head"
        case .mallard: duckName = "Mallard"

        }
        return duckName
    }
}

class DuckFactory {
    class func duck(ofType duckType: DuckType) -> DuckProtocol {
        var duck: DuckProtocol;
        switch duckType {
        case .dummy:
            duck = DummyDuck(quackBehavior: MuteQuack(), flyBehavior: FlyNoWay())
        case .decoy:
            duck = DecoyDuck(quackBehavior: MuteQuack(), flyBehavior: FlyNoWay())
        case .rocketJet:
            duck = RocketJetDuck(quackBehavior: Squeak(), flyBehavior: FlyWithRoketjet())
        case .redHead:
            duck = RedHeadDuck(quackBehavior: Squeak(), flyBehavior: FlyNoWay())
        case .mallard:
            duck = MallardDuck(quackBehavior: Quack(), flyBehavior: FlyWithWing())
        }
        return duck
    }
}

func testStrategy()
{
    print("-----------------Start Test Strategy 1-----------------")

    let mallardDuck = MallardDuck(quackBehavior: Quack(), flyBehavior: FlyWithWing())
    let redHeadDuck = RedHeadDuck(quackBehavior: Squeak(), flyBehavior: FlyNoWay())
    let decoyDuck = DecoyDuck(quackBehavior: MuteQuack(), flyBehavior: FlyNoWay())
    let rocketJetDuck = RocketJetDuck(quackBehavior: Squeak(), flyBehavior: FlyWithRoketjet())
    let dummyDuck = DummyDuck(quackBehavior: MuteQuack(), flyBehavior: FlyNoWay())

    let ducks:[DuckProtocol] = [mallardDuck, redHeadDuck, decoyDuck, rocketJetDuck, dummyDuck]
    
    for duck in ducks {
        performDuckAction(duck)
    }

}


func testStrategy2()
{
    print("-----------------Start Test Strategy 2-----------------")
    let mallardDuck = DuckFactory.duck(ofType: .mallard)
    
    let redHeadDuck = DuckFactory.duck(ofType: .redHead)
    let decoyDuck = DuckFactory.duck(ofType: .decoy)
    let rocketJetDuck = DuckFactory.duck(ofType: .rocketJet)
    let dummyDuck = DuckFactory.duck(ofType: .dummy)

    let ducks = [mallardDuck, redHeadDuck, decoyDuck, rocketJetDuck, dummyDuck]
    
    for duck in ducks {
        performDuckAction(duck)
    }


}


func performDuckAction(_ duck: DuckProtocol) {
    debugPrint()
    duck.display()
    duck.performFly()
    duck.performQuack()
    duck.swim()
}
testStrategy()

testStrategy2()

//---------------------------------------------------------

class DuckFactory2 {
    class func duck(ofType duckType: DuckType) -> Duck {
        var duck: Duck;
        switch duckType {
        case .dummy:
            duck = Duck(duckType: duckType, quackBehavior: MuteQuack(), flyBehavior: FlyNoWay())
        case .decoy:
            duck = Duck(duckType: duckType, quackBehavior: MuteQuack(), flyBehavior: FlyNoWay())
        case .rocketJet:
            duck = Duck(duckType: duckType, quackBehavior: Squeak(), flyBehavior: FlyWithRoketjet())
        case .redHead:
            duck = Duck(duckType: duckType, quackBehavior: Squeak(), flyBehavior: FlyNoWay())
        case .mallard:
            duck = Duck(duckType: duckType, quackBehavior: Quack(), flyBehavior: FlyWithWing())
        }
        return duck
    }
}

//
class Duck {
    private var quackBehavior: QuackBehavior
    private var flyBehavior: FlyingBehavior
    private var duckType: DuckType

    init(duckType: DuckType, quackBehavior: QuackBehavior, flyBehavior: FlyingBehavior) {
        self.duckType = duckType
        self.quackBehavior = quackBehavior
        self.flyBehavior = flyBehavior
    }
    
    
    func swim() {
        debugPrint("I can swim.")
    }
    
    func display() {
        debugPrint("I am \(duckType.description) duck.")
    }
    
    func performFly() {
        flyBehavior.fly()
    }
    
    func performQuack() {
        quackBehavior.quack()
    }
}

func testStrategy3()
{
    print("-----------------Start Test Strategy 3-----------------")

    let mallardDuck = DuckFactory2.duck(ofType: .mallard)
    let redHeadDuck = DuckFactory2.duck(ofType: .redHead)
    let decoyDuck = DuckFactory2.duck(ofType: .decoy)
    let rocketJetDuck = DuckFactory2.duck(ofType: .rocketJet)
    let dummyDuck = DuckFactory2.duck(ofType: .dummy)
    
    let ducks = [mallardDuck, redHeadDuck, decoyDuck, rocketJetDuck, dummyDuck]
    
    for duck in ducks {
        performDuckAction(duck)
    }

}

func performDuckAction(_ duck: Duck){
    debugPrint()
    duck.display()
    duck.performFly()
    duck.performQuack()
    duck.swim()
}

testStrategy3()
