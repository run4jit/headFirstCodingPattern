import UIKit

var str = "Hello, Adapter Pattern"

/// Adapter pattern: One or more interface can be used to adapte into one interface which client expecting.
protocol Duck {
    func fly()
    func quack()
}

class MallardDuck: Duck, CustomStringConvertible {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func fly() {
        debugPrint("I can fly.")
    }
    
    func quack() {
        debugPrint("Quack! Quack!")
    }
    
    var description: String {
        return "I am \(name)."
    }
}

protocol Turkey {
    func gobble()
    func fly()
}

class WildTurkey: Turkey, CustomStringConvertible {
    
    func gobble() {
        debugPrint("Gobble! Gobble!")
    }
    
    func fly() {
        debugPrint("I can fly shot distance.")
    }
    
    var description: String {
        return "I am Wild Turkey."
    }
}

class TurkeyAdapter: Duck, CustomStringConvertible {
    private let turkey: Turkey
    
    init(turkey: Turkey) {
        self.turkey = turkey
    }
    
    func fly() {
        for _ in 0..<5 {
            turkey.fly()
        }
    }
    
    func quack() {
        turkey.gobble()
        turkey.gobble()
        turkey.gobble()
    }
    
    var description: String {
        return "Actualy I am Turkey, but I act as Duck."
    }
}


class DuckTestDrive {
    let duck = MallardDuck(name: "Mallar Duck")
    let turkey = WildTurkey()
    let turkeyAsDuck: TurkeyAdapter
    init() {
        turkeyAsDuck = TurkeyAdapter(turkey: self.turkey)
    }
    
    func testDuck() {
        debugPrint("Duck Flying Test: \(duck.description)")
        duck.fly()
        debugPrint("Duck Quack Test: \(duck.description)")
        duck.quack()
    }
    
    func testTurkey() {
        debugPrint("Turkey Flying Test: \(turkey.description)")
        turkey.fly()
        debugPrint("Turkey Quack Test: \(turkey.description)")
        turkey.gobble()
    }
    
    func testTurkeyAdapter() {
        debugPrint("Turkey As Duck Flying Test: \(turkeyAsDuck.description)")
        turkeyAsDuck.fly()
        debugPrint("Turkey As Duck Quack Test: \(turkeyAsDuck.description)")
        turkeyAsDuck.quack()
    }
}

let testDrive = DuckTestDrive()
testDrive.testDuck()
testDrive.testTurkey()
testDrive.testTurkeyAdapter()


