import UIKit

var str = "Hello, Decorator Pattern"
/*
 Component(Beverage) and Decorator(Condiment) share same protocol/interface to each other.
 Concrete Component is the object we are going to add dnamic behavior.
 Decorator has a component object to hold concret Component.
 Decorator implements the same interface or abstract class as the component they are going to decorate.
 Decorator can extend the state of the compnent.
 Decorator can add new or extra computational methods.
 */



protocol BeverageProtocol: CustomStringConvertible {
    var cost: Double { get }
}

protocol CondimentDecorator: BeverageProtocol {
    
}

class DarkRoast: BeverageProtocol {
    var cost: Double {
        return 10.0
    }
    
    var description: String {
        return "Dark Roast"
    }
}

class HouseBlend: BeverageProtocol {
    var cost: Double {
        return 11.0
    }
    
    var description: String {
        return "HouseBlend"
    }
}

class Espresso: BeverageProtocol {
    var cost: Double {
        return 12.0
    }
    
    var description: String {
        return "Espresso"
    }
}

class Decaf: BeverageProtocol {
    var cost: Double {
        return 13.0
    }
    
    var description: String {
        return "Decaf"
    }
}


class Mocha: CondimentDecorator {
    private let beverage: BeverageProtocol
    init(beverage: BeverageProtocol) {
        self.beverage = beverage
    }
    
    var cost: Double {
        return self.beverage.cost + 1.0
    }
    
    var description: String {
        return self.beverage.description + " Mocha"
    }
}

class Wipe: CondimentDecorator {
    private let beverage: BeverageProtocol
    
    init(beverage: BeverageProtocol) {
        self.beverage = beverage
    }
    
    var cost: Double {
        return self.beverage.cost + 1.0
    }
    
    var description: String {
        return self.beverage.description + " Wipe"
    }
}

class Milk: CondimentDecorator {
    private let beverage: BeverageProtocol
    
    init(beverage: BeverageProtocol) {
        self.beverage = beverage
    }
    
    var cost: Double {
        return self.beverage.cost + 1.1
    }
    
    var description: String {
        return self.beverage.description + " Milk"
    }
}

class Soya: CondimentDecorator {
    private let beverage: BeverageProtocol
    
    init(beverage: BeverageProtocol) {
        self.beverage = beverage
    }
    
    var cost: Double {
        return self.beverage.cost + 1.3
    }
    
    var description: String {
        return self.beverage.description + " Soya"
    }
}

class StarBuzzCoffee {
    
//    let espreso = Espresso()
//    let darkRoast = DarkRoast()
//    let houseBlend = HouseBlend()
//    let decaf = Decaf()

//    let mocha = Mocha()
//    let wipe = Wipe()
//    let milk = Milk()
//    let soya = Soya()
    
    lazy var orderEspresso: BeverageProtocol = {
        var espreso: BeverageProtocol = Soya(beverage: Espresso())
        espreso = Mocha(beverage: espreso)
        espreso = Wipe(beverage: espreso)
        return espreso
    }()
    
    lazy var orderDarkRoast: BeverageProtocol = {
        var darkRoast: BeverageProtocol = Soya(beverage: DarkRoast())
        darkRoast = Mocha(beverage: darkRoast)
        darkRoast = Mocha(beverage: darkRoast)
        darkRoast = Wipe(beverage: darkRoast)
        return darkRoast
    }()
    
    lazy var orderHouseBlend: BeverageProtocol = {
        var houseBlend: BeverageProtocol = Soya(beverage: HouseBlend())
        houseBlend = Milk(beverage: houseBlend)
        houseBlend = Mocha(beverage: houseBlend)
        houseBlend = Wipe(beverage: houseBlend)
        return houseBlend
    }()
    
    lazy var orderDecaf: BeverageProtocol = {
        var decaf: BeverageProtocol = Decaf()
        decaf = Mocha(beverage: decaf)
        decaf = Milk(beverage: decaf)
        decaf = Soya(beverage: decaf)
        decaf = Wipe(beverage: decaf)
        return decaf
    }()

    func display(bevrage: BeverageProtocol) {
        debugPrint("\(bevrage.description) $\(bevrage.cost)")
    }
}

class TestStarBuzzCoffee {
    let starBuzzCoffee = StarBuzzCoffee()
    
    init() {
        testOrderDecaf()
        testOrderHouseBlend()
        testOrderDarkRoast()
        testOrderEspresso()
    }
    
    func testOrderDecaf() {
        starBuzzCoffee.display(bevrage: starBuzzCoffee.orderDecaf)
    }
    
    func testOrderHouseBlend() {
        starBuzzCoffee.display(bevrage: starBuzzCoffee.orderHouseBlend)
    }
    
    func testOrderDarkRoast() {
        starBuzzCoffee.display(bevrage: starBuzzCoffee.orderDarkRoast)
    }
    
    func testOrderEspresso() {
        starBuzzCoffee.display(bevrage: starBuzzCoffee.orderEspresso)
    }
}

TestStarBuzzCoffee()
