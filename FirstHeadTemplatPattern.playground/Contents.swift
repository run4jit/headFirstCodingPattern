import UIKit

var str = "Hello, Template Pattern"

class Coffee {
    func prepareRecipe() {
        boilWater()
        brewCoffeeGrinds()
        pourInCup()
        addSugarAndMilk()
    }
    
    func boilWater() {
        debugPrint("Boiling water")
    }
    
    func brewCoffeeGrinds() {
        debugPrint("Dripping Coffee through filter")
    }
    
    func pourInCup() {
        debugPrint("Pouring into cup")
    }
    
    func addSugarAndMilk() {
        debugPrint("Adding Sugar and Milk")
    }
}


class Tea {
    func prepareRecipe() {
        boilWater()
        steepTeaBag()
        pourInCup()
        addLemon()
    }
    
    func boilWater() {
        debugPrint("Boiling water")
    }
    
    func steepTeaBag() {
        debugPrint("Steeping the Tea")
    }
    
    func pourInCup() {
        debugPrint("Pouring into cup")
    }
    
    func addLemon() {
        debugPrint("Adding Lemon")
    }
}

class TestDriveRecipe {
    private let tea = Tea()
    private let coffee = Coffee()
    
    func testPrepareTea() {
        tea.prepareRecipe()
    }
    
    func testPrepareCoffee() {
        coffee.prepareRecipe()
    }
}

func testDriveRecipe() {
    let testDrive = TestDriveRecipe()
    testDrive.testPrepareTea()
    testDrive.testPrepareCoffee()
    debugPrint("-------------------------------------------")
}

testDriveRecipe()

// MARK Abstract which comman in class

// Both class are very similarity. We have to think to make reuse of common code.

//Can we use Abstraction to reuse code and sperate consern.

protocol CaffeeineBeverage {
    func prepareRecipe()
    func boilWater()
    func pourInCup()
}

extension CaffeeineBeverage {
    func boilWater() {
        debugPrint("Boiling water")
    }
    
    func pourInCup() {
        debugPrint("Pouring into cup")
    }
}

class Coffee1: CaffeeineBeverage {
    func prepareRecipe() {
        boilWater()
        brewCoffeeGrinds()
        pourInCup()
        addSugarAndMilk()
    }
        
    func brewCoffeeGrinds() {
        debugPrint("Dripping Coffee through filter")
    }
    
    func addSugarAndMilk() {
        debugPrint("Adding Sugar and Milk")
    }
}

class Tea1: CaffeeineBeverage {
    func prepareRecipe() {
        boilWater()
        steepTeaBag()
        pourInCup()
        addLemon()
    }
    
    func steepTeaBag() {
        debugPrint("Steeping the Tea")
    }
    
    func addLemon() {
        debugPrint("Adding Lemon")
    }
}

class TestDriveRecipe1 {
    private let tea = Tea1()
    private let coffee = Coffee1()
    
    func testPrepareTea() {
        tea.prepareRecipe()
    }
    
    func testPrepareCoffee() {
        coffee.prepareRecipe()
    }
}

func testDriveRecipe1() {
    let testDrive = TestDriveRecipe1()
    testDrive.testPrepareTea()
    testDrive.testPrepareCoffee()
    debugPrint("-------------------------------------------")
}

testDriveRecipe1()
// MARK Templet patten

/**
 1. Coffee uses brewCoffeeGrinds() and addSugarAndMilk() methods, while Tea uses steep steepTeaBag() and addLeamon() methods.
 2. Steeping and Brewing are not so different , they are pretty analogous. so make new method name brew()
 3. Adding Sugar and Milk is the same as adding Lemon. so make ne wmethod name addCondiments()
 */
// New Abstract class

protocol CaffeeineBeverage11 {
    func prepareRecipe()
    func boilWater()
    func pourInCup()
    func brew()
    func addCondiments()
}

extension CaffeeineBeverage11 {
    
    /**  Now the same prepareRecipe() method will be used to make both Tea and Coffee. No need of overriding.
         brew() and addCondiments() will be provided differently by both Coffee , Tea classes.
         boilWater() and pourInCup() common in both recipe so no need of overriding.
    */
    func prepareRecipe() {
        boilWater()
        brew()
        pourInCup()
        addCondiments()
    }
    
    func boilWater() {
        debugPrint("Boiling water")
    }
    
    func pourInCup() {
        debugPrint("Pouring into cup")
    }
}

class Coffee11: CaffeeineBeverage11 {

    func brew() {
        debugPrint("Dripping Coffee through filter")
    }
    
    func addCondiments() {
        debugPrint("Adding Sugar and Milk")
    }
}

class Tea11: CaffeeineBeverage11 {
    
    func brew() {
        debugPrint("Steeping the Tea")
    }
    
    func addCondiments() {
        debugPrint("Adding Lemon")
    }
}

class TestDriveRecipe11 {
    private let tea = Tea11()
    private let coffee = Coffee11()
    
    func testPrepareTea() {
        tea.prepareRecipe()
    }
    
    func testPrepareCoffee() {
        coffee.prepareRecipe()
    }
}

func testDriveRecipe11() {
    let testDrive = TestDriveRecipe11()
    testDrive.testPrepareTea()
    testDrive.testPrepareCoffee()
    debugPrint("-------------------------------------------")
}

testDriveRecipe11()

// MARK Templet with hook

protocol CaffeeineBeverage12 {
    func prepareRecipe()
    func boilWater()
    func pourInCup()
    func brew()
    func addCondiments()
//    var customerWantCondiments: Bool { get set }
    func customerWantCondiments() -> Bool
}

extension CaffeeineBeverage12 {
    func prepareRecipe() {
        boilWater()
        brew()
        pourInCup()
        if customerWantCondiments() {
            addCondiments()
        } else {
            debugPrint("Candiments not been added to recipe.")
        }
    }
    
    func boilWater() {
        debugPrint("Boiling water")
    }
    
    func pourInCup() {
        debugPrint("Pouring into cup")
    }
    
    func customerWantCondiments() -> Bool {
        return true
    }
}

class Coffee12: CaffeeineBeverage12 {

    func brew() {
        debugPrint("Dripping Coffee through filter")
    }
    
    func addCondiments() {
        debugPrint("Adding Sugar and Milk")
    }
    
    func customerWantCondiments() -> Bool {
        return false
    }
}

class Tea12: CaffeeineBeverage12 {
    
    func brew() {
        debugPrint("Steeping the Tea")
    }
    
    func addCondiments() {
        debugPrint("Adding Lemon")
    }
}

class TestDriveRecipe12 {
    private let tea = Tea12()
    private let coffee = Coffee12()
    
    func testPrepareTea() {
        tea.prepareRecipe()
    }
    
    func testPrepareCoffee() {
        coffee.prepareRecipe()
    }
}

func testDriveRecipe12() {
    let testDrive = TestDriveRecipe12()
    testDrive.testPrepareTea()
    testDrive.testPrepareCoffee()
}

testDriveRecipe12()

