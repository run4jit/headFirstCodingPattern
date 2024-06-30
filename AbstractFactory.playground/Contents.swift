import UIKit

var str = "Hello, Abstract Factory"

enum StoreLocation {
    case california, newYourk, chicago
    
    var location: String {
        switch self {
        case .california:
            return "California Pizza Store"
        case .chicago:
            return "Chicago Pizza Store"
        case .newYourk:
            return "New York Pizza Store"
        }
    }
}

protocol PizzaCostProtocol {
    var cost: Double { get }
}


enum PizzaType {
    case cheese, veggie, clam, pepperoni;
    
    var name: String {
        switch self {
            case .cheese:
                return "Cheese Pizza"
            case .veggie:
                return "Veggie Pizza"
            case .clam:
                return "Clam Pizza"
            case .pepperoni:
                return "Pepperoni Pizza"
        }
    }
    
    // Temperature in °C
    var cookingTemperature: Int {
        switch self {
            case .cheese:
                return 350
            case .veggie:
                return 250
            case .clam:
                return 275
            case .pepperoni:
                return 300
        }
    }
    
    //Time in minutes
    var cookingTime: Int {
        switch self {
            case .cheese: return 25
            case .veggie: return 27
            case .clam: return 25
            case .pepperoni: return 30
        }
    }
}


enum PizzaSize: CustomStringConvertible {
    case regular, medium, large, giant, monster;
    
    static var defaultSize: PizzaSize {
        return .regular
    }
    
    //Size in cm
    var size: Float {
        switch self {
            case .regular: return 117.70
            case .medium: return 224.5
            case .large: return 433.0
            case .giant: return 845.7
            case .monster: return 12.61
        }
    }
    
    var description: String {
        return "sdafsaf".capitalized
    }
}


protocol Dough {
    
}

class VeryThinCrustDough: Dough {
    
}

class ThinCrustDough: Dough {
    
}

class ThickCrustDough: Dough {
    
}

protocol Clams {
    
}

class FreshClams: Clams {
    
}

class FrozenClams: Clams {
    
}

class Calamari: Clams {
    
}

protocol Sauce {
    
}

class MarinaraSauce: Sauce {
    
}

class PlumTomatoSauce: Sauce {
    
}

class BruschettaSauce: Sauce {
    
}

protocol Cheese {
    
}

class RegggianoCheese: Cheese {
    
}

class MozzarellaCheese: Cheese {
    
}

class GoatCheese: Cheese {
    
}

protocol Pepperoni {
    
}

class SwezwanPepperoni: Pepperoni {
    
}

class RedHotPepperoni: Pepperoni {
    
}

class SlicedPepperoni: Pepperoni {
    
}

class NonePepperoni: Pepperoni {
    
}

enum Veggie: CaseIterable, CustomStringConvertible {
    case onion
    case tomato
    case capsicum
    case mushroom
    case olive
    case spinach
    case eggplant
    case parmesan
    case reggiano
    case redPaper
    case oregano
    case garlic

    
    var description: String {
        switch self {
        case .onion:
            return "Onion"
        case .tomato:
            return "Tomato"
        case .capsicum:
            return "Capsicum"
        case .mushroom:
            return "Mushroom"
        case .olive:
            return "Black Olives"
        case .spinach:
            return "Spinach"
        case .eggplant:
            return "Eggplant"
        case .parmesan:
            return "Parmesan"
        case .reggiano:
            return "Reggiano"
        case .redPaper:
            return "Red Paper"
        case .oregano:
            return "Oregano"
        case .garlic:
            return "Garlic"

        }
        
    }
    

}

protocol PizzaIngredientFactory {
    
    func createDough() -> Dough
    func createCheese() -> Cheese
    func createSauce() -> Sauce
    func createCalms() -> Clams
    func createVeggies(type: PizzaType) -> [Veggie]
    func createPepperoni() -> Pepperoni
}

class NYPizzaIngredientFactory: PizzaIngredientFactory {
    func createDough() -> Dough {
        return ThinCrustDough()
    }
    
    func createCheese() -> Cheese {
        return RegggianoCheese()
    }
    
    func createSauce() -> Sauce {
        return MarinaraSauce()
    }
    
    func createCalms() -> Clams {
        return FreshClams()
    }
    
    func createVeggies(type: PizzaType) -> [Veggie] {
        switch type {
        case .cheese:
            return [.reggiano, .garlic]
        case .veggie:
            return [.reggiano, .mushroom, .onion, .redPaper, .eggplant]
        case .clam:
            return[.reggiano]
        case .pepperoni:
            return[.reggiano, .onion, .redPaper]
        }
//        return Veggie.allCases
    }
    
    func createPepperoni() -> Pepperoni {
        return SlicedPepperoni()
    }
    
}


class ChicagoPizzaIngredientFactory: PizzaIngredientFactory {
    func createDough() -> Dough {
        return ThickCrustDough()
    }
    
    func createCheese() -> Cheese {
        return MozzarellaCheese()
    }
    
    func createSauce() -> Sauce {
        return PlumTomatoSauce()
    }
    
    func createCalms() -> Clams {
        return FrozenClams()
    }
    
    func createVeggies(type: PizzaType) -> [Veggie] {
        switch type {
        case .cheese:
            return [.parmesan, .oregano]
        case .veggie:
            return [.parmesan, .eggplant, .spinach, .olive]
        case .clam:
            return[.parmesan]
        case .pepperoni:
            return[.parmesan, .eggplant, .spinach, .olive, .redPaper]
        }
//        return Veggie.allCases
    }
    
    func createPepperoni() -> Pepperoni {
        return RedHotPepperoni()
    }
}

class CaliforniaPizzaIngredientFactory: PizzaIngredientFactory {
    func createDough() -> Dough {
        return VeryThinCrustDough()
    }
    
    func createCheese() -> Cheese {
        return GoatCheese()
    }
    
    func createSauce() -> Sauce {
        return BruschettaSauce()
    }
    
    func createCalms() -> Clams {
        return Calamari()
    }
    
    func createVeggies(type: PizzaType) -> [Veggie] {
        switch type {
        case .cheese:
            return [.oregano, .garlic]
        case .veggie:
            return [.oregano, .tomato, .capsicum, .redPaper, .onion, .eggplant]
        case .clam:
            return[.oregano]
        case .pepperoni:
            return[.oregano, .tomato, .capsicum, .redPaper]
        }
//        return Veggie.allCases
    }
    
    func createPepperoni() -> Pepperoni {
        return SwezwanPepperoni()
    }
}


protocol Pizza: PizzaCostProtocol {
    var name: String { get set }
    var dough: Dough { get set }
    var sauce: Sauce { get set }
    var vaggies: [Veggie] { get set }
    var clam: Clams { get set }
    var pepperoni: Pepperoni { get set }
    var cheese: Cheese { get set }

    var pizzaType: PizzaType { get set }

    var pizzaSize: PizzaSize { get set }
    
    func prepare()
    func bake()
    func cut()
    func box()
//    func cost() -> Double
}

extension Pizza {
    
    func bake() {
        debugPrint("Bake for \(pizzaType.cookingTime) minutes at \(pizzaType.cookingTemperature)°C")
    }
    
    func cut() {
        debugPrint("Cutting Pizza in diagonal slices.")
    }
     
    func box() {
        debugPrint("Place pizza in official PizzaStore box.")
    }
    
    func costOfPizza(type: PizzaType, size: PizzaSize) -> Double {
        switch size {
            case .regular:
                switch type {
                    case .cheese: return 450.00
                    case .veggie: return 375.00
                    case .clam: return 300.00
                    case .pepperoni: return 350.00
                }
            case .medium:
                switch type {
                    case .cheese: return 450.00 * 1.5
                    case .veggie: return 375.00 * 1.5
                    case .clam: return 300.00 * 1.5
                    case .pepperoni: return 350.00 * 1.5
                }
            case .large:
                switch type {
                    case .cheese: return 450.00 * 2.0
                    case .veggie: return 375.00 * 2.0
                    case .clam: return 300.00 * 2.0
                    case .pepperoni: return 350.00 * 2.0
                }
            case .giant:
                switch type {
                    case .cheese: return 450.00 * 2.30
                    case .veggie: return 375.00 * 2.30
                    case .clam: return 300.00 * 2.30
                    case .pepperoni: return 350.00 * 2.30
                }
            case .monster:
                switch type {
                    case .cheese: return 450.00 * 2.75
                    case .veggie: return 375.00 * 2.75
                    case .clam: return 300.00 * 2.75
                    case .pepperoni: return 350.00 * 2.75
                }
        }
    }
    
    var description: String {
        
        var des = "Pizza: \(name), Dough: \(type(of: dough)), Sauce: \(type(of: sauce)), Clam: \(type(of: clam)), Pepperoni: \(type(of: pepperoni)), Cheese: \(type(of: cheese)) \nPizaSize: \(pizzaSize.size)cm \nVeggies: ["
        
        for vaggie in vaggies {
            des += " \(vaggie.description),"
        }
        des = String(des.dropLast(1)) // removing last "," from string
        des += " ]\n"
        let roundedCost = String(format: "%.2f", cost)
        des += "Cost: \(roundedCost)"
        return des
    }
}

class CheesePizza: Pizza {
    
    var name: String
    
    var dough: Dough
    
    var sauce: Sauce
    
    var vaggies: [Veggie]
    
    var clam: Clams
    
    var pepperoni: Pepperoni
    
    var cheese: Cheese

    var pizzaType: PizzaType
    
    var pizzaSize: PizzaSize
    
    var cost: Double {
        return costOfPizza(type: pizzaType, size: pizzaSize)
    }
    
    private var ingredientFactory: PizzaIngredientFactory
    
    init(ingredientFactory: PizzaIngredientFactory) {
        name = "CheesePizza"
        self.ingredientFactory = ingredientFactory
        dough = ingredientFactory.createDough()
        sauce = ingredientFactory.createSauce()
        cheese = ingredientFactory.createCheese()
        vaggies = ingredientFactory.createVeggies(type: .cheese)
        clam = ingredientFactory.createCalms()
        pepperoni = ingredientFactory.createPepperoni()
        pizzaType = .cheese
        pizzaSize = .defaultSize
        
    }
    
    
    
    func prepare() {
        debugPrint("Preparing \(name)")
        
    }
}

class PepperoniPizza: Pizza {
    
    var name: String
    
    var dough: Dough
    
    var sauce: Sauce
    
    var vaggies: [Veggie]
    
    var clam: Clams
    
    var pepperoni: Pepperoni
    
    var cheese: Cheese
    
    var pizzaType: PizzaType
    
    var pizzaSize: PizzaSize

    var cost: Double {
        return costOfPizza(type: pizzaType, size: pizzaSize)
    }
    
    private var ingredientFactory: PizzaIngredientFactory
    
    init(ingredientFactory: PizzaIngredientFactory) {
        name = "PepperoniPizza"
        self.ingredientFactory = ingredientFactory
        dough = ingredientFactory.createDough()
        sauce = ingredientFactory.createSauce()
        cheese = ingredientFactory.createCheese()
        vaggies = ingredientFactory.createVeggies(type: .pepperoni)
        clam = ingredientFactory.createCalms()
        pepperoni = ingredientFactory.createPepperoni()
        pizzaType = .pepperoni
        pizzaSize = .defaultSize
        
    }
    
    func prepare() {
        debugPrint("Preparing \(name)")
        
    }
}

class VeggiePizza: Pizza {
    
    var name: String
    
    var dough: Dough
    
    var sauce: Sauce
    
    var vaggies: [Veggie]
    
    var clam: Clams
    
    var pepperoni: Pepperoni
    
    var cheese: Cheese

    var pizzaType: PizzaType
    
    var pizzaSize: PizzaSize
    
    var cost: Double {
        return costOfPizza(type: pizzaType, size: pizzaSize)
    }
    
    private var ingredientFactory: PizzaIngredientFactory
    
    init(ingredientFactory: PizzaIngredientFactory) {
        name = "VeggiePizza"
        self.ingredientFactory = ingredientFactory
        dough = ingredientFactory.createDough()
        sauce = ingredientFactory.createSauce()
        cheese = ingredientFactory.createCheese()
        vaggies = ingredientFactory.createVeggies(type: .veggie)
        clam = ingredientFactory.createCalms()
        pepperoni = ingredientFactory.createPepperoni()
        pizzaType = .veggie
        pizzaSize = .defaultSize
    }
    
    func prepare() {
        debugPrint("Preparing \(name)")
        
    }
}

class ClamPizza: Pizza {
    
    var name: String
    
    var dough: Dough
    
    var sauce: Sauce
    
    var vaggies: [Veggie]
    
    var clam: Clams
    
    var pepperoni: Pepperoni
    
    var cheese: Cheese

    var pizzaType: PizzaType
    
    var pizzaSize: PizzaSize
    
    var cost: Double {
        return costOfPizza(type: pizzaType, size: pizzaSize)
    }
    
    private var ingredientFactory: PizzaIngredientFactory
    
    init(ingredientFactory: PizzaIngredientFactory) {
        name = "ClamPizza"
        self.ingredientFactory = ingredientFactory
        dough = ingredientFactory.createDough()
        sauce = ingredientFactory.createSauce()
        cheese = ingredientFactory.createCheese()
        vaggies = ingredientFactory.createVeggies(type: .clam)
        clam = ingredientFactory.createCalms()
        pepperoni = ingredientFactory.createPepperoni()
        pizzaType = .clam
        pizzaSize = .defaultSize
        
    }
    
    func prepare() {
        debugPrint("Preparing \(name)")
        
    }
}

class CustomPizza: Pizza {
    
    var name: String
    
    var dough: Dough
    
    var sauce: Sauce
    
    var vaggies: [Veggie]
    
    var clam: Clams
    
    var pepperoni: Pepperoni
    
    var cheese: Cheese

    var pizzaType: PizzaType

    var pizzaSize: PizzaSize

    var cost: Double {
        return costOfPizza(type: pizzaType, size: pizzaSize)
    }
    
    private var ingredientFactory: PizzaIngredientFactory
    
    init(pizzaType: PizzaType, ingredientFactory: PizzaIngredientFactory) {
        self.pizzaType = pizzaType
        name = pizzaType.name
        
        self.ingredientFactory = ingredientFactory
        dough = ingredientFactory.createDough()
        sauce = ingredientFactory.createSauce()
        cheese = ingredientFactory.createCheese()
        vaggies = ingredientFactory.createVeggies(type: pizzaType)
        clam = ingredientFactory.createCalms()
        pepperoni = ingredientFactory.createPepperoni()
        pizzaSize = .defaultSize
        
    }
    
    func prepare() {
        debugPrint("Preparing \(name)")
        
    }
}

protocol PizzaStore {
    var storeLocation: String {get set}
    
    func orderPizza(_ type: PizzaType, size: PizzaSize) -> Pizza
    
    func createPizza(_ type: PizzaType) -> Pizza
    
    init(ingredientFactory: PizzaIngredientFactory)
}

extension PizzaStore {
    func orderPizza(_ type: PizzaType, size: PizzaSize = .defaultSize) -> Pizza {
        var pizza = createPizza(type)
        pizza.pizzaSize = size
        
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        
        return pizza
    }
    
    func orderPizza(_ pizza: Pizza) -> Pizza {
        pizza.prepare()
        pizza.bake()
        pizza.cut()
        pizza.box()
        
        return pizza
    }
}


class NYPizzaStore: PizzaStore {
    var storeLocation = "New York Pizza Store"
    private var ingredientFactory: PizzaIngredientFactory
    
    required init(ingredientFactory: PizzaIngredientFactory = NYPizzaIngredientFactory()) {
        self.ingredientFactory = ingredientFactory
    }

    
    func createPizza(_ type: PizzaType) -> Pizza {
        
        switch type {
        case .cheese:
            return CheesePizza(ingredientFactory: ingredientFactory)
        case .veggie:
            return VeggiePizza(ingredientFactory: ingredientFactory)
        case .clam:
            return ClamPizza(ingredientFactory: ingredientFactory)
        case .pepperoni:
            return PepperoniPizza(ingredientFactory: ingredientFactory)
        }
    }
}

class ChicagoPizzaStore: PizzaStore {
    var storeLocation = "Chicago Pizza Store"
    private var ingredientFactory: PizzaIngredientFactory
    
    required init(ingredientFactory: PizzaIngredientFactory = ChicagoPizzaIngredientFactory()) {
        self.ingredientFactory = ingredientFactory
    }
    
    func createPizza(_ type: PizzaType) -> Pizza {
        switch type {
        case .cheese:
            return CheesePizza(ingredientFactory: ingredientFactory)
        case .veggie:
            return VeggiePizza(ingredientFactory: ingredientFactory)
        case .clam:
            return ClamPizza(ingredientFactory: ingredientFactory)
        case .pepperoni:
            return PepperoniPizza(ingredientFactory: ingredientFactory)
        }
    }
}

class CaliforniaPizzaStore: PizzaStore {
    var storeLocation = "California Pizza Store"
    private var ingredientFactory: PizzaIngredientFactory
    
    required init(ingredientFactory: PizzaIngredientFactory = CaliforniaPizzaIngredientFactory()) {
        self.ingredientFactory = ingredientFactory
    }
    
    func createPizza(_ type: PizzaType) -> Pizza {
        switch type {
        case .cheese:
            return CheesePizza(ingredientFactory: ingredientFactory)
        case .veggie:
            return VeggiePizza(ingredientFactory: ingredientFactory)
        case .clam:
            return ClamPizza(ingredientFactory: ingredientFactory)
        case .pepperoni:
            return PepperoniPizza(ingredientFactory: ingredientFactory)
        }
    }
}


class AnyWhewerPizzaStore: PizzaStore {
    var storeLocation: String
    private var ingredientFactory: PizzaIngredientFactory
    
    internal required init(ingredientFactory: PizzaIngredientFactory) {
        self.ingredientFactory = ingredientFactory
        self.storeLocation = "AnyWhewer"
    }
    
    init(storeLocation: StoreLocation, ingredientFactory: PizzaIngredientFactory) {
        self.ingredientFactory = ingredientFactory
        self.storeLocation = storeLocation.location
    }
    
    
    func createPizza(_ type: PizzaType) -> Pizza {
        switch type {
        case .cheese:
            return CheesePizza(ingredientFactory: ingredientFactory)
        case .veggie:
            return VeggiePizza(ingredientFactory: ingredientFactory)
        case .clam:
            return ClamPizza(ingredientFactory: ingredientFactory)
        case .pepperoni:
            return PepperoniPizza(ingredientFactory: ingredientFactory)
        }
    }
}



struct TestPizzaStore {
    static func testStore() {
        let nyStore = NYPizzaStore()
        let chicagoStore = ChicagoPizzaStore()
        let californiaStore = CaliforniaPizzaStore()

        let stores: [PizzaStore] = [nyStore, chicagoStore, californiaStore]
        
        for store in stores {
            print("\(store.storeLocation)")
            print("\(store.orderPizza(.cheese, size: .large).description)")
            print("-----------------------------------------")
            print("\(store.orderPizza(.pepperoni, size: .giant).description)")
            print("-----------------------------------------")
            print("\(store.orderPizza(.clam, size: .medium).description)")
            print("-----------------------------------------")
            print("\(store.orderPizza(.veggie, size: .monster).description)")
            print("-----------------------------------------")
        }
        
        //
        let nyPizzaIngredientFactory = NYPizzaIngredientFactory()
        
        let chicagoPizzaIngredientFactory = ChicagoPizzaIngredientFactory()
        let californiaPizzaIngredientFactory = CaliforniaPizzaIngredientFactory()
        
        let customNewYourkStore = AnyWhewerPizzaStore(storeLocation: .newYourk, ingredientFactory: nyPizzaIngredientFactory)
        let customChicagoStore = AnyWhewerPizzaStore(storeLocation: .chicago, ingredientFactory: chicagoPizzaIngredientFactory)
        let customcaliforniaStore = AnyWhewerPizzaStore(storeLocation: .newYourk, ingredientFactory: californiaPizzaIngredientFactory)
        
        let customStores = [customNewYourkStore, customChicagoStore, customcaliforniaStore]
        
        print("####################################################")
        for store in customStores {
            print("\(store.storeLocation)")
            var pizza = store.createPizza(.cheese)
            pizza.pizzaSize = .large
            print("\(store.orderPizza(pizza).description)")
            print("-----------------------------------------")
            pizza = store.createPizza(.pepperoni)
            pizza.pizzaSize = .giant
            print("\(store.orderPizza(pizza).description)")
            print("-----------------------------------------")
            pizza = store.createPizza(.clam)
            pizza.pizzaSize = .medium
            print("\(store.orderPizza(pizza).description)")
            print("-----------------------------------------")
            pizza = store.createPizza(.veggie)
            pizza.pizzaSize = .giant
            print("\(store.orderPizza(pizza).description)")
            print("-----------------------------------------")
        }

        
    }
}


TestPizzaStore.testStore()
