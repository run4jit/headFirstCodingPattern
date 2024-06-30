import UIKit

var str = "Hello, Command Pattern"

/**
 Building remote control useing Command pattern
 */

typealias RemoteCommand = Command & UndoCommand

enum SwitchState: CustomStringConvertible {
    case on
    case off
    
    var description: String {
        switch self {
        case .on:
            return "On"
        case .off:
            return "Off"
        }
    }
}

extension SwitchState {
    var doorState: String {
        switch self {
        case .off:
            return "Close"
        case .on:
            return "Open"
        }
    }
}

protocol SwitchProtocol {
    var location: String {get set}
    func switchOn()
    func switchOff()
    var state: SwitchState {get set}
}

class Light: SwitchProtocol, CustomStringConvertible {
    var location: String
    var state: SwitchState = .off
    
    init(location: String) {
        self.location = location
    }
    
    func switchOn() {
        state = .on
        debugPrint("\(self.description)")
    }
    
    func switchOff() {
        state = .off
        debugPrint("\(self.description)")
    }
    
    var description: String {
        return "\(location) light is \(state)"
    }
}

class Fan: SwitchProtocol, CustomStringConvertible {

    enum Speed: Int, CustomStringConvertible {
        case off = 0
        case low
        case medium
        case high
        
        var description: String {
            switch self {
            case .off:
                return "Zero"
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .high:
                return "High"
            }
        }
    }
    
    var location: String
    var state: SwitchState = .off
    var speed: Speed = .off {
        didSet {
            previousSpeed = speed
        }
    }
    private var previousSpeed: Speed = .off
    
    init(location: String) {
        self.location = location
    }
    
    func switchOn() {
        state = .on
        speed = speed == .off ? .low : speed
        debugPrint("\(self.description)")
    }
    
    func switchOff() {
        state = .off
        speed = .off
        debugPrint("\(self.description)")
    }
    
    func undoState() {
        self.speed = self.previousSpeed
        if speed == .off {
            self.switchOff()
        } else {
            self.switchOn()
        }
    }
    
    var description: String {
        return "\(location) fan is \(state) at speed of \(speed.description)"
    }
}

class Door: SwitchProtocol, CustomStringConvertible {
    
    var location: String
    var state: SwitchState = .off
    
    init(location: String) {
        self.location = location
    }
    
    func switchOn() {
        state = .on
        debugPrint("\(self.description)")
    }
    
    func switchOff() {
        state = .off
        debugPrint("\(self.description)")
    }
    
    var description: String {
        return "\(location) door is \(state.doorState)"
    }
}

class Telivision: SwitchProtocol, CustomStringConvertible {
    
    var location: String
    var state: SwitchState = .off
    
    init(location: String) {
        self.location = location
    }
    
    func switchOn() {
        state = .on
        debugPrint("\(self.description)")
    }
    
    func switchOff() {
        state = .off
        debugPrint("\(self.description)")
    }
    
    var description: String {
        return "\(location) telivision is \(state)"
    }
}

class Stereo: SwitchProtocol, CustomStringConvertible {
    
    var location: String
    var state: SwitchState = .off
    
    init(location: String) {
        self.location = location
    }
    
    func switchOn() {
        state = .on
        debugPrint("\(self.description)")
    }
    
    func switchOff() {
        state = .off
        debugPrint("\(self.description)")
    }
    
    var description: String {
        return "\(location) stereo is \(state)"
    }
}

protocol Command {
    func execute()
}

protocol UndoCommand {
    func undo()
}

class LightOnCommand: Command, CustomStringConvertible {
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.switchOn()
        debugPrint("LightOnCommand : \(self.description)")
    }
    
    var description: String {
        return "Light on command: \(light.description)"
    }
}

extension LightOnCommand: UndoCommand {
    func undo() {
        light.switchOff()
        debugPrint("LightOnCommand: \(self.description)")
    }
}

class LightOffCommand: Command, CustomStringConvertible {
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func execute() {
        light.switchOff()
        debugPrint("LightOffCommand : \(self.description)")
    }
    
    var description: String {
        return "Light off command: \(light.description)"
    }

}

extension LightOffCommand: UndoCommand {
    func undo() {
        light.switchOn()
        debugPrint("LightOffCommand: \(self.description)")
    }
}

class FanOffCommand: Command, CustomStringConvertible {
    private let fan: Fan
    
    init(fan: Fan) {
        self.fan = fan
    }
    
    func execute() {
        fan.switchOff()
        debugPrint("FanOffCommand : \(self.description)")
    }
    
    var description: String {
        return "Fan off command: \(fan.description)"
    }
}

extension FanOffCommand: UndoCommand {
    func undo() {
        fan.undoState()
        debugPrint("FanOffCommand: \(self.description)")
    }
}

class FanHighCommand: Command, CustomStringConvertible {
    private let fan: Fan
    
    init(fan: Fan) {
        self.fan = fan
    }
    
    func execute() {
        fan.switchOn()
        fan.speed = Fan.Speed.high
        debugPrint("FanHighCommand: \(self.description)")
    }
    
    var description: String {
        return "Fan high command \(fan.description)"
    }
}

extension FanHighCommand: UndoCommand {
    func undo() {
        fan.undoState()
        debugPrint("FanHighCommand: \(self.description)")
    }
}

class FanLowCommand: Command, CustomStringConvertible {
    private let fan: Fan
    
    init(fan: Fan) {
        self.fan = fan
    }
    
    func execute() {
        fan.switchOn()
        fan.speed = Fan.Speed.low
        debugPrint("FanLowCommand: \(self.description)")
    }
    
    var description: String {
        return "Fan low command \(fan.description)"
    }
}
extension FanLowCommand: UndoCommand {
    func undo() {
        fan.undoState()
        debugPrint("FanLowCommand: \(self.description)")
    }
}

class MainDoorOpenCommand: Command, CustomStringConvertible {
    private let door: Door
    
    init(door: Door) {
        self.door = door
    }
    
    func execute() {
        door.switchOn()
        debugPrint("MainDoorOpenCommand: execute \(self.description)")
    }
    
    var description: String {
        return "Main Door Open Command: \(door.description)"
    }
}
extension MainDoorOpenCommand: UndoCommand {
    func undo() {
        door.switchOff()
        debugPrint("MainDoorOpenCommand: undo \(self.description)")
    }
}


class MainDoorCloseCommand: Command, CustomStringConvertible {
    private let door: Door
    
    init(door: Door) {
        self.door = door
    }
    
    func execute() {
        door.switchOff()
        debugPrint("MainDoorCloseCommand: \(self.description)")
    }
    
    var description: String {
        return "Main Door Close command \(door.description)"
    }
}
extension MainDoorCloseCommand: UndoCommand {
    func undo() {
        door.switchOn()
        debugPrint("MainDoorCloseCommand: \(self.description)")
    }
}

class GarageDoorOpenCommand: Command, CustomStringConvertible {
    private let door: Door
    
    init(door: Door) {
        self.door = door
    }
    
    func execute() {
        door.switchOn()
        debugPrint("GarageDoorOpenCommand: \(self.description)")
    }
    
    var description: String {
        return "Garage Door Open command \(door.description)"
    }
}
extension GarageDoorOpenCommand: UndoCommand {
    func undo() {
        door.switchOff()
        debugPrint("GarageDoorOpenCommand: \(self.description)")
    }
}


class GarageDoorCloseCommand: Command, CustomStringConvertible {
    private let door: Door
    
    init(door: Door) {
        self.door = door
    }
    
    func execute() {
        door.switchOff()
        debugPrint("GarageDoorCloseCommand: \(self.description)")
    }
    
    var description: String {
        return "Garage Door Close command \(door.description)"
    }
}
extension GarageDoorCloseCommand: UndoCommand {
    func undo() {
        door.switchOn()
        debugPrint("GarageDoorCloseCommand: \(self.description)")
    }
}


class SteroOnCommand: Command, CustomStringConvertible {
    private let stereo: Stereo
    
    init(stereo: Stereo) {
        self.stereo = stereo
    }
    
    func execute() {
        stereo.switchOn()
        debugPrint("SteroOnCommand: \(self.description)")
    }
    
    var description: String {
        return "Stero On command \(stereo.description)"
    }
}
extension SteroOnCommand: UndoCommand {
    func undo() {
        stereo.switchOff()
        debugPrint("SteroOnCommand: \(self.description)")
    }
}


class SteroOffCommand: Command, CustomStringConvertible {
    private let stereo: Stereo
    
    init(stereo: Stereo) {
        self.stereo = stereo
    }
    
    func execute() {
        stereo.switchOff()
        debugPrint("SteroOffCommand: \(self.description)")
    }
    
    var description: String {
        return "Stero Off command \(stereo.description)"
    }
}
extension SteroOffCommand: UndoCommand {
    func undo() {
        stereo.switchOn()
        debugPrint("SteroOffCommand: \(self.description)")
    }
}

class TelevisionOnCommand: Command, CustomStringConvertible {
    private let tv: Telivision
    
    init(tv: Telivision) {
        self.tv = tv
    }
    
    func execute() {
        tv.switchOn()
        debugPrint("TelevisionOnCommand: \(self.description)")
    }
    
    var description: String {
        return "Television On command \(tv.description)"
    }
}
extension TelevisionOnCommand: UndoCommand {
    func undo() {
        tv.switchOff()
        debugPrint("TelevisionOnCommand: \(self.description)")
    }
}


class TelevisionOffCommand: Command, CustomStringConvertible {
    private let tv: Telivision
    
    init(tv: Telivision) {
        self.tv = tv
    }
    
    func execute() {
        tv.switchOff()
        debugPrint("TelevisionOffCommand: \(self.description)")
    }
    
    var description: String {
        return "Television Off command \(tv.description)"
    }
}
extension TelevisionOffCommand: UndoCommand {
    func undo() {
        tv.switchOn()
        debugPrint("TelevisionOffCommand: \(self.description)")
    }
}

class PartyCommand: RemoteCommand, CustomStringConvertible {
    private let commands: [RemoteCommand]
    private var isPartyOn = false
    init(commands: [RemoteCommand]) {
        self.commands = commands
    }
    
    func execute() {
        isPartyOn = true
        debugPrint(self.description)
        for command in commands {
            command.execute()
        }
    }
    
    var description: String {
        if isPartyOn {
            return "Pary is on..."
        } else {
            return "Pary is off..."
        }
    }
}
extension PartyCommand {
    func undo() {
        isPartyOn = false
        debugPrint(self.description)
        for command in commands {
            command.undo()
        }
    }
}

class SecureCommand: RemoteCommand, CustomStringConvertible {
    private let commands: [RemoteCommand]
    init(commands: [RemoteCommand]) {
        self.commands = commands
    }
    
    func execute() {
        debugPrint(self.description)
        for command in commands {
            command.execute()
        }
    }
    
    var description: String {
        return "Hybernet mode..."
    }
}
extension SecureCommand {
    func undo() {
        debugPrint("House secure undo command not supported.")
    }
}


enum RemoteSlot: Int {
    case mainDoor = 0
    case livingRoomLight
    case livingRoomFan
    case kitchenLight
    case garageDoor
    case livingRoomStereo
    case livingRoomTV
    case party
    case secureMode
}

class RemoteControl1 {
    var onCommands = [RemoteCommand]()
    var offCommands = [RemoteCommand]()
    var undoCommand: RemoteCommand?
    var partyCommand: PartyCommand?
    var secureCommand: SecureCommand?
    
    private let mainDoor = Door(location: "Main Door")
    private let livingRoomLight = Light(location: "Living Room")
    private let kitchenLight = Light(location: "Kitchen Room")
    private let livingRoomFan = Fan(location: "Living Room")
    let garageDoor = Door(location: "Garage Door")
    let stereo = Stereo(location: "Living Room")
    let tv = Telivision(location: "Living Room")

    //Light command
    init() {
        initializedRemote()
    }
    
    private func initializedRemote() {
        setCommandFor(slot: .mainDoor, onCommand: MainDoorOpenCommand(door: mainDoor), offCommand: MainDoorCloseCommand(door: mainDoor))
        setCommandFor(slot: .livingRoomLight, onCommand: LightOnCommand(light: livingRoomLight), offCommand: LightOffCommand(light: livingRoomLight))
        setCommandFor(slot: .livingRoomFan, onCommand: FanHighCommand(fan: livingRoomFan), offCommand: FanOffCommand(fan: livingRoomFan))
        setCommandFor(slot: .kitchenLight, onCommand: LightOnCommand(light: kitchenLight), offCommand: LightOffCommand(light: kitchenLight))
        setCommandFor(slot: .garageDoor, onCommand: GarageDoorOpenCommand(door: garageDoor), offCommand: GarageDoorCloseCommand(door: garageDoor))
        setCommandFor(slot: .livingRoomStereo, onCommand: SteroOnCommand(stereo: stereo), offCommand: SteroOffCommand(stereo: stereo))
        setCommandFor(slot: .livingRoomTV, onCommand: TelevisionOnCommand(tv: tv), offCommand: TelevisionOffCommand(tv: tv))
        
        partyCommand = PartyCommand(commands: [LightOnCommand(light: livingRoomLight)
            , FanHighCommand(fan: livingRoomFan)
            , SteroOnCommand(stereo: stereo)
            , TelevisionOnCommand(tv: tv)
        ])
        
        secureCommand = SecureCommand(commands: offCommands)
    }
    
    func setCommandFor(slot: RemoteSlot, onCommand: RemoteCommand, offCommand: RemoteCommand) {
        let index = slot.rawValue
        onCommands.insert(onCommand, at: index)
        offCommands.insert(offCommand, at: index)
    }
    
    func remoteOnButtonPushed(forSlot slot: RemoteSlot) {
        let index = slot.rawValue
        if index < onCommands.count {
            let command = onCommands[index]
            command.execute()
            undoCommand = command
        } else {
            debugPrint("No command has been set for this button.")
        }
    }
    
    func remoteOffButtonPushed(forSlot slot: RemoteSlot) {
        let index = slot.rawValue
        if index < offCommands.count {
            let command = offCommands[index]
            command.execute()
            undoCommand = command
        } else {
            debugPrint("No command has been set for this button.")
        }
    }
    
    func undobuttonPushed() {
        undoCommand?.undo()
    }
    
    func party(isOn: Bool) {
        isOn ? partyCommand?.execute() : partyCommand?.undo()
    }
    
    func secureHome() {
        secureCommand?.execute()
    }
}

class SimpleRemoteTest {
    private let remote = RemoteControl1()
    
    func testAllSwitch() {
        //Light & Fan ON-OFF
        remote.remoteOnButtonPushed(forSlot: .mainDoor)
        remote.remoteOffButtonPushed(forSlot: .mainDoor)
        
        remote.remoteOnButtonPushed(forSlot: .livingRoomLight)
        remote.remoteOffButtonPushed(forSlot: .livingRoomLight)
        
        remote.remoteOnButtonPushed(forSlot: .livingRoomFan)
        remote.remoteOffButtonPushed(forSlot: .livingRoomFan)
        
        remote.remoteOnButtonPushed(forSlot: .kitchenLight)
        remote.remoteOffButtonPushed(forSlot: .kitchenLight)

        remote.remoteOnButtonPushed(forSlot: .garageDoor)
        remote.remoteOffButtonPushed(forSlot: .garageDoor)

        remote.remoteOnButtonPushed(forSlot: .livingRoomStereo)
        remote.remoteOffButtonPushed(forSlot: .livingRoomStereo)

        remote.remoteOnButtonPushed(forSlot: .livingRoomTV)
        remote.remoteOffButtonPushed(forSlot: .livingRoomTV)

    }
    
    func testParty() {
        //Party
        remote.party(isOn: true)
        
        remote.party(isOn: false)
    }
    
    func testSecureHome() {
        //Secure Home
        remote.secureHome()
        remote.secureCommand?.undo()
    }
}

extension RemoteSlot {
    var commandOnText: String {
        switch self {
        case .mainDoor:
            return "Main Door Open Command Executed"
        case .livingRoomLight:
            return "Living room ligh On Command Executed"
        case .livingRoomFan:
            return "Living room fan On Command Executed"
        case .kitchenLight:
            return "Kitchen ligh On Command Executed"
        case .garageDoor:
            return "Garage Door Open Command Executed"
        case .livingRoomStereo:
            return "Living room Stereo On Command Executed"
        case .livingRoomTV:
            return "Living room Telivision On Command Executed"
        case .party:
            return "Party On Command Executed"
        case .secureMode:
            return "Home in Hybernet mode..."
        }
    }
    
    var commandOffText: String {
        switch self {
        case .mainDoor:
            return "Main Door Close Command Executed"
        case .livingRoomLight:
            return "Living room ligh Off Command Executed"
        case .livingRoomFan:
            return "Living room fan Off Command Executed"
        case .kitchenLight:
            return "Kitchen ligh Off Command Executed"
        case .garageDoor:
            return "Garage Door Close Command Executed"
        case .livingRoomStereo:
            return "Living room Stereo Off Command Executed"
        case .livingRoomTV:
            return "Living room Telivision Off Command Executed"
        case .party:
            return "Party Off Command Executed"
        case .secureMode:
            return "Undo command in home secure Command NOT Allowed To Execute"
        }
    }
    
}


class RemoteControl2 {

    typealias comandType = ()->Void

    private var onCommands = [comandType]()
    private var offCommands = [comandType]()
    private var undoCommand: (comandType)?
    private var partyOnCommands: [comandType]?
    private var partyOffCommands: [comandType]?
    private var secureCommands: [comandType]?
    
    private let mainDoor = Door(location: "Main Door")
    private let livingRoomLight = Light(location: "Living Room")
    private let kitchenLight = Light(location: "Kitchen Room")
    private let livingRoomFan = Fan(location: "Living Room")
    let garageDoor = Door(location: "Garage Door")
    let stereo = Stereo(location: "Living Room")
    let tv = Telivision(location: "Living Room")

    //Light command
    init() {
        self.initializedRemote()
    }
    
    private func initializedRemote() {
        setCommandFor(slot: .mainDoor, onCommand: mainDoor.switchOn , offCommand: mainDoor.switchOff)
        
        setCommandFor(slot: .livingRoomLight, onCommand: livingRoomLight.switchOn , offCommand: livingRoomLight.switchOff)

        setCommandFor(slot: .livingRoomFan, onCommand: livingRoomFan.switchOn , offCommand: livingRoomFan.switchOff)
        livingRoomFan.speed = .high

        setCommandFor(slot: .kitchenLight, onCommand: kitchenLight.switchOn , offCommand: kitchenLight.switchOff)

        setCommandFor(slot: .garageDoor, onCommand: garageDoor.switchOn , offCommand: garageDoor.switchOff)
        
        setCommandFor(slot: .livingRoomStereo, onCommand: stereo.switchOn , offCommand: stereo.switchOff)

        setCommandFor(slot: .livingRoomTV, onCommand: tv.switchOn , offCommand: tv.switchOff)

        

        partyOnCommands = [livingRoomLight.switchOn
            , livingRoomFan.switchOn
            , stereo.switchOn
            , tv.switchOn
        ]

        partyOffCommands = [livingRoomLight.switchOff
            , livingRoomFan.switchOff
            , stereo.switchOff
            , tv.switchOff
        ]

        secureCommands = offCommands
        
    }
        
    func setCommandFor(slot: RemoteSlot, onCommand:@escaping ()->Void, offCommand:@escaping ()->Void) {
        let index = slot.rawValue
        onCommands.insert(onCommand, at: index)
        offCommands.insert(offCommand, at: index)
    }
    
    func remoteOnButtonPushed(forSlot slot: RemoteSlot) {
        let index = slot.rawValue
        if index < onCommands.count {
            debugPrint("\(slot.commandOnText)")
            let command = onCommands[index]
            command()
            undoCommand = command
        } else {
            debugPrint("No command has been set for this button.")
        }
    }
    
    func remoteOffButtonPushed(forSlot slot: RemoteSlot) {
        let index = slot.rawValue
        if index < offCommands.count {
            debugPrint("\(slot.commandOffText)")
            let command = offCommands[index]
            command()
            undoCommand = command
        } else {
            debugPrint("No command has been set for this button.")
        }
    }
    
    func undobuttonPushed() {
        undoCommand?()
    }
    
    func party(isOn: Bool) {
        isOn ? partyOn() : partyOff()
    }
    
    private func partyOn() {
        guard let partyCommands = partyOnCommands else { return }
        debugPrint("Party On Command Executed")
        for command in partyCommands {
            command()
        }
    }
    
    private func partyOff() {
        guard let partyOffCommands = partyOffCommands else { return }
        debugPrint("Party Off Command Executed")
        for command in partyOffCommands {
            command()
        }
    }
    
    func secureHome() {
        guard let secureCommands = secureCommands else { return }
        debugPrint("Home security On Command Executed")
        for command in secureCommands {
            command()
        }
    }
}

class SimpleRemoteTest1 {
    private let remote = RemoteControl2()
    
    func testAllSwitch() {
        //Light & Fan ON-OFF
        remote.remoteOnButtonPushed(forSlot: .mainDoor)
        remote.remoteOffButtonPushed(forSlot: .mainDoor)
        
        remote.remoteOnButtonPushed(forSlot: .livingRoomLight)
        remote.remoteOffButtonPushed(forSlot: .livingRoomLight)
        
        remote.remoteOnButtonPushed(forSlot: .livingRoomFan)
        remote.remoteOffButtonPushed(forSlot: .livingRoomFan)
        
        remote.remoteOnButtonPushed(forSlot: .kitchenLight)
        remote.remoteOffButtonPushed(forSlot: .kitchenLight)

        remote.remoteOnButtonPushed(forSlot: .garageDoor)
        remote.remoteOffButtonPushed(forSlot: .garageDoor)

        remote.remoteOnButtonPushed(forSlot: .livingRoomStereo)
        remote.remoteOffButtonPushed(forSlot: .livingRoomStereo)

        remote.remoteOnButtonPushed(forSlot: .livingRoomTV)
        remote.remoteOffButtonPushed(forSlot: .livingRoomTV)

    }
    
    func testParty() {
        //Party
        remote.party(isOn: true)
        
        remote.party(isOn: false)
    }
    
    func testSecureHome() {
        //Secure Home
        remote.secureHome()
    }
}


func commandPatternTest() {
    let simpleRemoteTest = SimpleRemoteTest()
    simpleRemoteTest.testAllSwitch()
    simpleRemoteTest.testParty()
    simpleRemoteTest.testSecureHome()
}

func commandPatternTest1() {
    let simpleRemoteTest = SimpleRemoteTest1()
    simpleRemoteTest.testAllSwitch()
    simpleRemoteTest.testParty()
    simpleRemoteTest.testSecureHome()
}


commandPatternTest()
debugPrint("----------------------------------------------------------------------")
commandPatternTest1()
