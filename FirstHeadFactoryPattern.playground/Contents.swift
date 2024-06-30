import UIKit

var str = "Hello, Simple Factory Pattern."

enum PizzaType {
    case cheese, pepperoni, clam, veggie
}

protocol PizaComponent: CustomStringConvertible {
    var type: PizzaType { get }
    func prepare()
    func bake()
    func cut()
    func box()
    
    var description: String { get }
    var cost: Double { get }
//    init(type: PizzaType)
}

class Pizza: PizaComponent {
    var type: PizzaType
    init(type: PizzaType) {
        self.type = type
    }
    
    func prepare() {
        debugPrint("Preparing...")
    }
    
    func bake() {
        debugPrint("Baking...")
    }
    
    func cut() {
        debugPrint("Cutting...")
    }
    
    func box() {
        debugPrint("Boxing...")
    }
    
    var description: String {
        return "Should not be creating object of this class"
    }
    
    var cost: Double {
        return 0
    }
}

class CheesePizza: Pizza {
    init() {
        super.init(type: .cheese)
    }
    
    override var description: String {
        return "Cheese Pizza"
    }
    
    override var cost: Double {
        return 10.0
    }
}

class PepperoniPizza: Pizza {
    init() {
        super.init(type: .pepperoni)
    }
    
    override var description: String {
        return "Pepperoni Pizza"
    }
    
    override var cost: Double {
        return 11.0
    }
}

class ClamPizza: Pizza {
    init() {
        super.init(type: .clam)
    }
    
    override var description: String {
        return "Clam Pizza"
    }
    
    override var cost: Double {
        return 12.0
    }
}

class VeggiePizza: Pizza {
    init() {
        super.init(type: .veggie)
    }
    
    override var description: String {
        return "Veggie Pizza"
    }
    
    override var cost: Double {
        return 13.0
    }
}

class PizzaStore {
    private let factory: SimplePizzaFactory
    
    init(factory: SimplePizzaFactory) {
        self.factory = factory
    }
    
    func orderPizza(type: PizzaType) -> Pizza {
        let pizza = self.factory.createPizza(type: type)
        
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()

        return pizza
    }
}

class SimplePizzaFactory {
    func createPizza(type: PizzaType) -> Pizza {
        switch type {
        case .cheese:
            return CheesePizza()
        case .clam:
            return ClamPizza()
        case .pepperoni:
            return PepperoniPizza()
        case .veggie:
            return VeggiePizza()
        }
    }
}


class TestPizzaStore {
    let store = PizzaStore(factory: SimplePizzaFactory())
    
    func testStore(type: PizzaType) {
        let pizza = self.store.orderPizza(type: type)
        debugPrint("\(pizza.description) cost: $\(pizza.cost)")
    }
}

let testStore = TestPizzaStore()
testStore.testStore(type: .cheese)
testStore.testStore(type: .veggie)
testStore.testStore(type: .clam)
testStore.testStore(type: .pepperoni)

