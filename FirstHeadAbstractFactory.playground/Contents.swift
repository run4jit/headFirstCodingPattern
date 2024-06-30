import UIKit


var str = "Hello, Abstract Factory Pattern."

enum PizzaType {
    case cheese, pepperoni, clam, veggie
    
    static let defaultValue: PizzaType = .cheese
}

enum PizzaBaseType {
    case normal, thinCrust, thickCrust
    static let defaultValue: PizzaBaseType = .normal

}

protocol PizzaTypeProtocol: PizzaProtocol {
    var type: PizzaType { get set }
}

protocol PizzaBaseDecorator: PizzaProtocol {
    var baseType: PizzaBaseType { get set }
}

protocol IngredientDecorator: PizzaProtocol {
    
}

protocol PizzaProtocol {
//    var pizzaType: PizzaType { get }
//    var baseType: PizzaBaseType { get }

    var description: String { get }
    var cost: Double { get }
}

class NormalBasePizza:Pizza, PizzaBaseDecorator {
    var baseType: PizzaBaseType = .normal
    private let pizza: PizzaProtocol
    init(pizza: PizzaProtocol) {
        self.pizza = pizza
    }
    
    var description: String {
        return self.pizza.description + " Normal Base"
    }
    
    var cost: Double {
        return self.pizza.cost + 5.0
    }
}

class ThickCrustBasePizza:Pizza, PizzaBaseDecorator {
    var baseType: PizzaBaseType = .thickCrust
    private let pizza: PizzaProtocol
    init(pizza: PizzaProtocol) {
        self.pizza = pizza
    }
    
    var description: String {
        return self.pizza.description + " Thick Crust Base"
    }
    
    var cost: Double {
        return self.pizza.cost + 7.0
    }
}

class ThinCrustBasePizza:Pizza, PizzaBaseDecorator {
    var baseType: PizzaBaseType = .thinCrust
    private let pizza: PizzaProtocol
    init(pizza: PizzaProtocol) {
        self.pizza = pizza
    }
    
    var description: String {
        return self.pizza.description + " Thin Crust Base"
    }
    
    var cost: Double {
        return self.pizza.cost + 3.0
    }
}

class CheesePizza: Pizza, PizzaTypeProtocol {
    var type: PizzaType = .cheese
    var description: String {
        return "Cheese Pizza"
    }
    
    var cost: Double {
        return 10.0
    }
}

class PepperoniPizza: Pizza, PizzaTypeProtocol {
    var type: PizzaType = .pepperoni
    var description: String {
        return "Pepperoni Pizza"
    }
    
    var cost: Double {
        return 10.0
    }
}

class ClamPizza: Pizza, PizzaTypeProtocol {
    var type: PizzaType = .clam
    var description: String {
        return "Clam Pizza"
    }
    
    var cost: Double {
        return 10.0
    }
}

class VeggiePizza: Pizza, PizzaTypeProtocol {
    var type: PizzaType = .veggie
    var description: String {
        return "Veggie Pizza"
    }
    
    var cost: Double {
        return 10.0
    }
}

protocol PizaComponent {
    func prepare()
    func bake()
    func cut()
    func box()
    
    
//    init(type: PizzaType)
}



class Pizza: PizaComponent {
//    var description: String { return self.description }
////
//    var cost: Double { return self.cost }
    
//    var baseType: PizzaBaseType = .defaultValue
    
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
    
}


typealias CoustomPizza = Pizza & PizzaProtocol


protocol PizzaStoreProtocol {
    func createPizza(type: PizzaType) -> CoustomPizza
    func orderPizza(type: PizzaType) -> CoustomPizza
}

extension PizzaStoreProtocol {
    func orderPizza(type: PizzaType) -> CoustomPizza {
        let pizza = createPizza(type: type)

        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()

        return pizza
    }
}

class PizzaStore: PizzaStoreProtocol {
    private let factory: PizzaFactoryProtocol
    init(factory: PizzaFactoryProtocol) {
        self.factory = factory
    }
    
    func createPizza(type: PizzaType) -> CoustomPizza {
        return self.factory.createPizza(type: type)
    }
}

protocol PizzaFactoryProtocol {
    func createPizza(type: PizzaType) -> CoustomPizza
}

class NYStylePizzaFactory: PizzaFactoryProtocol {
    private func createNYStylePizza(_ pizza: CoustomPizza) -> CoustomPizza  {
        return ThinCrustBasePizza(pizza: pizza)
    }
    func createPizza(type: PizzaType) -> CoustomPizza {
        switch type {
        case .cheese:
            return createNYStylePizza(CheesePizza())
        case .clam:
            return createNYStylePizza(ClamPizza())
        case .pepperoni:
            return createNYStylePizza(PepperoniPizza())
        case .veggie:
            return createNYStylePizza(VeggiePizza())
        }
    }
}

class ChicagoStylePizzaFactory: PizzaFactoryProtocol {
    private func createChicagoStylePizza(_ pizza: CoustomPizza) -> CoustomPizza  {
        return ThickCrustBasePizza(pizza: pizza)
    }
    func createPizza(type: PizzaType) -> CoustomPizza {
        switch type {
        case .cheese:
            return createChicagoStylePizza(CheesePizza())
        case .clam:
            return createChicagoStylePizza(ClamPizza())
        case .pepperoni:
            return createChicagoStylePizza(PepperoniPizza())
        case .veggie:
            return createChicagoStylePizza(VeggiePizza())
        }
    }
}

//
//class TestPizzaStore {
//    let nyPizzaStore = PizzaStore(factory: NYStylePizzaFactory())
//    func testNYStore() {
//        let pizza = nyPizzaStore.orderPizza(type: .cheese)
//        debugPrint("\(pizza.description) cost: $\(pizza.cost)")
//    }
//}
