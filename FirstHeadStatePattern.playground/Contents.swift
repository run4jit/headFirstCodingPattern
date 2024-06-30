import UIKit

var str = "Hello, StatePattern"

class GumballMachine: CustomStringConvertible {
    
    enum GumballState: CustomStringConvertible {
        case soldOut // no Gumball left in machine
        case noQuater // no Quater inserted, ready for starting new game.
        case hasQuater // user can truns crank, or eject quater
        case sold // dispense gumball, then gumball == 0 => soldOut elseif gumball > 0 then noQuater state
        
        var description: String {
            switch self {
            case .sold:
                return "A gumball comes rolling out the slot."
            case .soldOut:
                return "Machin is sold out."
            case .noQuater:
                return "Machin is waiting for quater."
           case .hasQuater:
                return "Turn crank to get gumball."
            }
        }
    }
    
    var state: GumballState = .soldOut
    var count: Int = 0
    
    var description: String {
        return state.description
    }
    
    init(count: Int) {
        self.count = count
        if count > 0 {
            state = .noQuater
        }
    }
    
    func insertQuater() {
        if state == .hasQuater {
            debugPrint("You can not insert another Quater.")
        } else if state == .noQuater {
            state = .hasQuater
            debugPrint("You have inserted a Quater")
        } else if state == .sold {
            debugPrint("Please wait, We are already giving you a gumball.")
        } else if state == .soldOut {
            debugPrint("You can not insert Quater. Machin is sold out.")
        }
    }
    
    func ejectQuater() {
        if state == .hasQuater {
            state = .noQuater
            debugPrint("Quater returned.")
        } else if state == .noQuater {
            debugPrint("You have not inserted a Quater")
        } else if state == .sold {
            debugPrint("Sorry, You already turned the crank.")
        } else if state == .soldOut {
            debugPrint("You can not eject. You have not inserted Quater yet.")
        }
    }
    
    func trunCrank() {
        if state == .hasQuater {
            state = .sold
            debugPrint("You have truned the crank.")
            dispense()
        } else if state == .noQuater {
            debugPrint("You have not inserted a Quater")
        } else if state == .sold {
            debugPrint("Turning twice will not give you another gumball.")
        } else if state == .soldOut {
            debugPrint("You can turn, but there is no gumball.")
        }
    }
    
    func dispense() {
        if state == .hasQuater {
            debugPrint("No gumball dispense.")
        } else if state == .noQuater {
            debugPrint("You have pay first.")
        } else if state == .sold {
            count -= 1
            debugPrint("Rolling out gumball.")
            if count == 0 {
                state = .soldOut
                debugPrint("Opps, out of gumball!")
            } else {
                state = .noQuater
            }
        } else if state == .soldOut {
            debugPrint("No gumball dispense.")
        }
    }
    
    func printCurrentState() {
        debugPrint("\(description) gumball = \(count)")
    }
}

func testGumballMachin(count: Int) {
    let gumballMachine = GumballMachine(count: count)
    gumballMachine.printCurrentState()
    
    gumballMachine.insertQuater()
    gumballMachine.trunCrank()
    gumballMachine.printCurrentState()
    
    gumballMachine.insertQuater()
    gumballMachine.ejectQuater()
    gumballMachine.trunCrank()
    gumballMachine.printCurrentState()
    
    gumballMachine.insertQuater()
    gumballMachine.trunCrank()
    gumballMachine.insertQuater()
    gumballMachine.trunCrank()
    gumballMachine.ejectQuater()
    gumballMachine.printCurrentState()
    
    
    gumballMachine.insertQuater()
    gumballMachine.insertQuater()
    gumballMachine.trunCrank()
    gumballMachine.insertQuater()
    gumballMachine.trunCrank()
    gumballMachine.insertQuater()
    gumballMachine.trunCrank()
    gumballMachine.printCurrentState()

}

testGumballMachin(count: 5)



// MARK: Implementation using State Patern

class GumballMachine1 {
    var count: Int
    var noQuater: NoQuaterState?
    var hasQuater: HasQuaterState?
    var sold: SoldState?
    var soldOut: SoldOutState?
    
    var currentState: GumballState?

    init(gumballCount: Int) {
        
        self.count = gumballCount
        
        noQuater = NoQuaterState(machine: self)
        hasQuater = HasQuaterState(machine: self)
        sold = SoldState(machine: self)
        soldOut = SoldOutState(machine: self)
        
        if gumballCount == 0 {
            currentState = soldOut
        } else {
            currentState = noQuater
        }
    }
    
    
    func updateState(state: GumballState?) {
        currentState = state
    }
    
    func insertQuater() {
        currentState?.insertQuater()
    }
    
    func ejectQuater() {
        currentState?.ejectQuater()
    }
    
    func trunCrank() {
        currentState?.turnCrank()
        dispense()
    }
    
    func dispense() {
        count -= 1
        currentState?.dispense()
    }
    
    func printCurrentState() {
        debugPrint("\(currentState?.description ?? "") gumball = \(count)")
    }
}

protocol GumballState: CustomStringConvertible {
    func insertQuater()
    func ejectQuater()
    func turnCrank()
    func dispense()
}


class NoQuaterState: GumballState {
    
    weak var gumballMachin: GumballMachine1?
    
    init(machine: GumballMachine1) {
        gumballMachin = machine
    }
    
    func insertQuater() {
        debugPrint("You just inserted a Quater.")
        gumballMachin?.updateState(state: gumballMachin?.hasQuater)
    }
    
    func ejectQuater() {
        debugPrint("You have not inserted a quater.")
    }
    
    func turnCrank() {
        debugPrint("You turn, but there is no quater.")
    }
    
    func dispense() {
        debugPrint("You need to pay first.")
    }
    
    var description: String {
        return "Machin is waiting for quater."
    }
}

class HasQuaterState: GumballState {
    
    weak var gumballMachin: GumballMachine1?
    
    init(machine: GumballMachine1) {
        gumballMachin = machine
    }
    
    func insertQuater() {
        debugPrint("You can not insert another Quater.")
    }
    
    func ejectQuater() {
        gumballMachin?.updateState(state: gumballMachin?.noQuater)
        debugPrint("Quater returned.")
    }
    
    func turnCrank() {
        gumballMachin?.updateState(state: gumballMachin?.sold)
        debugPrint("You have truned the crank.")
    }
    
    func dispense() {
        debugPrint("Kindly, turn the crank to get gumball.")
    }
    
    var description: String {
        return "Turn crank to get gumball."
    }
}

class SoldState: GumballState {
    
    weak var gumballMachin: GumballMachine1?
    
    init(machine: GumballMachine1) {
        gumballMachin = machine
    }
    
    func insertQuater() {
        debugPrint("Please wait, We are already giving you a gumball.")
    }
    
    func ejectQuater() {
        debugPrint("Sorry, You already turned the crank.")
    }
    
    func turnCrank() {
        debugPrint("Turning twice will not give you another gumball.")
    }
    
    func dispense() {
        debugPrint("Rolling out gumball.")
        if gumballMachin?.count == 0 {
            debugPrint("Opps, out of gumball!")
            gumballMachin?.updateState(state: gumballMachin?.soldOut)
        } else {
            gumballMachin?.updateState(state: gumballMachin?.noQuater)
        }
    }
    
    var description: String {
        return "A gumball comes rolling out the slot."
    }
}

class SoldOutState: GumballState {
    
    weak var gumballMachin: GumballMachine1?
    
    init(machine: GumballMachine1) {
        gumballMachin = machine
    }
    
    func insertQuater() {
        debugPrint("You can not insert Quater. Machin is sold out.")
        
    }
    
    func ejectQuater() {
        debugPrint("You can not eject. You have not inserted Quater yet.")
    }
    
    func turnCrank() {
        debugPrint("You can turn, but there is no gumball.")
    }
    
    func dispense() {
        debugPrint("No gumball dispense.")
    }
    
    var description: String {
        return "Machin is sold out."
    }
}

func testGumballMachin1(count: Int) {

    let gumballMachine = GumballMachine1(gumballCount: 5)
    
    gumballMachine.printCurrentState()
    
    gumballMachine.insertQuater()
    gumballMachine.trunCrank()
    gumballMachine.printCurrentState()
    
    gumballMachine.insertQuater()
    gumballMachine.ejectQuater()
    gumballMachine.trunCrank()
    gumballMachine.printCurrentState()
    
    gumballMachine.insertQuater()
    gumballMachine.trunCrank()
    gumballMachine.insertQuater()
    gumballMachine.trunCrank()
    gumballMachine.ejectQuater()
    gumballMachine.printCurrentState()
    
    
    gumballMachine.insertQuater()
    gumballMachine.insertQuater()
    gumballMachine.trunCrank()
    gumballMachine.insertQuater()
    gumballMachine.trunCrank()
    gumballMachine.insertQuater()
    gumballMachine.trunCrank()
    gumballMachine.printCurrentState()

}
debugPrint("------------------------------------------------------------")

testGumballMachin(count: 5)
