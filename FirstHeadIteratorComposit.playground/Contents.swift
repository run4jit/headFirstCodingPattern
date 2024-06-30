import UIKit
import Foundation

var str = "Hello, Iterator pattern"


//Pancake House & Objectiville Dinner Hotel merged one use Array and other use dictionary to sotre menu. Both restorent depend on menu items.

// We have to create combine these and create new Menu.

struct MenuItem: CustomStringConvertible {
    let name: String
    let detail: String
    let vegetarian: Bool
    let price: Double
    
    var description: String {
        return "name: \(name) detail: \(detail) vegetarian: \(vegetarian) price: $\(price) "
    }
}

class Node<T> {
    let item: T
    var nextNode: Node<T>?
    
    init(item: T) {
        self.item = item
        self.nextNode = nil
    }
}

struct LinkList<T: CustomStringConvertible>: CustomStringConvertible {
    var head: Node<T>?
    
    init() {
        head = nil
    }
    
    //insert
    mutating func insert(node: Node<T>) {
        if head == nil {
            self.head = node
        } else {
            var tempNode = head
            while tempNode?.nextNode != nil {
                tempNode = tempNode?.nextNode
            }
            tempNode?.nextNode = node
        }
    }
    //nextElement
    
    mutating func nextElement() -> T? {
        let tempNode = head
        self.head = head?.nextNode
        tempNode?.nextNode = nil
        return tempNode?.item
    }
    
    var hasNextElement: Bool {
        return head != nil
    }
    
    //search
    
    var description: String {
        var tempNode = self.head
        var des = ""
        while tempNode != nil {
            des += tempNode?.item.description ?? "" + "\n"
            tempNode = tempNode?.nextNode
        }
        return des
    }
}



class PancakeHouse: CustomStringConvertible {
    private(set) var menuItems = [MenuItem]()
    
    init() {
        let item1 = MenuItem(name: "K&B's Pancake Breakfast1", detail: "Pancakes with scrambled eggs and tost", vegetarian: false, price: 2.99)
        addMenu(item: item1)
        let item2 = MenuItem(name: "K&B's Pancake Breakfast2", detail: "Pancakes with scrambled eggs and tost", vegetarian: true, price: 3.99)
        addMenu(item: item2)
        let item3 = MenuItem(name: "K&B's Pancake Breakfast3", detail: "Pancakes with scrambled eggs and tost", vegetarian: false, price: 4.99)
        addMenu(item: item3)
        let item4 = MenuItem(name: "K&B's Pancake Breakfast4", detail: "Pancakes with scrambled eggs and tost", vegetarian: true, price: 5.99)
        addMenu(item: item4)
    }
    
    func addMenu(item: MenuItem) {
        self.menuItems.append(item)
    }
    
    var description: String {
        let des = menuItems.map { (item) -> String in
            return item.description
        }
        return des.description
    }
}
debugPrint("PancakeHouse \(PancakeHouse().description)")


class DinnerHotel: CustomStringConvertible {
    private(set) var menuList = LinkList<MenuItem>()
    
    init() {
        let item1 = MenuItem(name: "Vegetarian BLT1", detail: "Bacon with lettuce &  tomato on whole wheat", vegetarian: true, price: 3.99)
        addMenu(item: item1)
        let item2 = MenuItem(name: "Vegetarian BLT2", detail: "Bacon with lettuce &  tomato on whole wheat", vegetarian: false, price: 4.99)
        addMenu(item: item2)
        let item3 = MenuItem(name: "Vegetarian BLT3", detail: "Bacon with lettuce &  tomato on whole wheat", vegetarian: true, price: 5.99)
        addMenu(item: item3)
        let item4 = MenuItem(name: "Vegetarian BLT4", detail: "Bacon with lettuce &  tomato on whole wheat", vegetarian: false, price: 6.99)
        addMenu(item: item4)
    }
    
    func addMenu(item: MenuItem) {
        let node = Node(item: item)
        menuList.insert(node: node)
    }
    
    var description: String {
        return self.menuList.description
    }
}

debugPrint("DinnerHotel \(DinnerHotel().description)")


class CombinedHotelFirstVersion {
    private let Dinner: DinnerHotel
    private let pancakeHouse: PancakeHouse
    
    init(Dinner: DinnerHotel, pancakeHouse: PancakeHouse) {
        self.Dinner = Dinner
        self.pancakeHouse = pancakeHouse
    }
    
    func printMenu() {
        let pancakeMenuArray = pancakeHouse.menuItems
        
        debugPrint("Break Fast Items")
        for item in pancakeMenuArray {
            debugPrint(item.description, terminator: "\n")
        }
        
        let DinnerMenuList = Dinner.menuList
        debugPrint("Lunch Menu Items")
        var tempNode = DinnerMenuList.head
        while tempNode != nil {
            guard let item = tempNode?.item else { break }
            debugPrint(item.description, terminator: "\n")
            tempNode = tempNode?.nextNode
        }
    }
}

CombinedHotelFirstVersion(Dinner: DinnerHotel(), pancakeHouse: PancakeHouse()).printMenu()

protocol MenuItemIterator {
    var hasNext: Bool {get}
    func next() -> MenuItem?
}

class PancakeIterator: MenuItemIterator {
    private let items: [MenuItem]
    private var currentIndex: Int
    init(items: [MenuItem]) {
        self.items = items
        self.currentIndex = items.count > 0 ? 0 : -1
    }
    
    var hasNext: Bool {
        return self.currentIndex < items.count
    }
    
    func next() -> MenuItem? {
        if hasNext {
            let item = items[currentIndex]
            self.currentIndex += 1
            return item
        } else {
            return nil
        }
    }
}

class DinnerIterator: MenuItemIterator {
    private var itemsHead: LinkList<MenuItem>
    
    init(items: LinkList<MenuItem>) {
        self.itemsHead = items
    }
    
    var hasNext: Bool {
        return itemsHead.hasNextElement
    }
    
    func next() -> MenuItem? {
        return itemsHead.nextElement()
    }
}

protocol Menu {
    func createIterator() -> MenuItemIterator
}

extension PancakeHouse: Menu {
    func createIterator() -> MenuItemIterator {
        return PancakeIterator(items: self.menuItems)
    }
}

extension DinnerHotel: Menu {
    func createIterator() -> MenuItemIterator {
        return DinnerIterator(items: self.menuList)
    }
}



class Cafe: CustomStringConvertible {
    private(set) var menuItems = [String : MenuItem]()
    
    init() {
        let item1 = MenuItem(name: "Cafe 1", detail: "Pancakes with scrambled eggs and tost", vegetarian: false, price: 2.99)
        addMenu(item1.name, item: item1)
        let item2 = MenuItem(name: "Cafe 2", detail: "Pancakes with scrambled eggs and tost", vegetarian: true, price: 3.99)
        addMenu(item2.name, item: item2)
        let item3 = MenuItem(name: "Cafe 3", detail: "Pancakes with scrambled eggs and tost", vegetarian: false, price: 4.99)
        addMenu(item3.name, item: item3)
        let item4 = MenuItem(name: "Cafe 4", detail: "Pancakes with scrambled eggs and tost", vegetarian: true, price: 5.99)
        addMenu(item4.name, item: item4)
    }
    
    func addMenu(_ name: String, item: MenuItem) {
        menuItems[name] = item
    }
    
    var description: String {
        let des = menuItems.values.map { (item) -> String in
            return item.description
        }
        return des.description
    }
}

class CafeMenuIterator: MenuItemIterator {
    private let menus: [String: MenuItem]
    private var index = 0
    init(menus: [String: MenuItem]) {
        self.menus = menus
    }
    
    var hasNext: Bool {
        return index < menus.count
    }
    
    func next() -> MenuItem? {
        let values = [MenuItem](menus.values)
        if index < values.count {
            let item = values[index]
            index += 1
            return item
        } else {
            return nil
        }
    }
    
    
}

extension Cafe: Menu {
    func createIterator() -> MenuItemIterator {
//        return self.menuItems.makeIterator() as! MenuItemIterator
        return CafeMenuIterator(menus: self.menuItems)
    }
}


class CombinedHotelSecondVersion {
    private let dinner: DinnerHotel
    private let pancakeHouse: PancakeHouse
    private let cafe: Cafe

    init(Dinner: DinnerHotel, pancakeHouse: PancakeHouse, cafe: Cafe) {
        self.dinner = Dinner
        self.pancakeHouse = pancakeHouse
        self.cafe = cafe
    }
    
    func printMenu() {
        debugPrint("Second Version Break Fast Items")
        printMenu(iterator: pancakeHouse.createIterator())

        debugPrint("Second Version Lunch Menu Items")
        printMenu(iterator: dinner.createIterator())
        
        debugPrint("Second Version Cafe Menu Items")
        printMenu(iterator: cafe.createIterator())
    }
    
    func printMenu(iterator: MenuItemIterator) {
        while iterator.hasNext {
            if let item = iterator.next() {
                debugPrint(item.description, terminator: "\n")
            }
        }
    }
}

CombinedHotelSecondVersion(Dinner: DinnerHotel(), pancakeHouse: PancakeHouse(), cafe: Cafe()).printMenu()

/*
class CombinedHotelThirdVersion {
    private let pancakeHouse: PancakeHouse
    private let cafe: Cafe

    init(pancakeHouse: PancakeHouse, cafe: Cafe) {
        self.pancakeHouse = pancakeHouse
        self.cafe = cafe
    }
    
    func printMenu() {
        debugPrint("Second Version Break Fast Items")
        printMenu(iterator: pancakeHouse.menuItems.makeIterator())

        debugPrint("Second Version Cafe Menu Items")
        printMenu(iterator: cafe.menuItems.makeIterator())
    }
    
    func printMenu(iterator: Iterator) {
        while iterator.hasNext {
            if let item = iterator.next() {
                debugPrint(item.description, terminator: "\n")
            }
        }
    }
}

CombinedHotelThirdVersion(pancakeHouse: PancakeHouse(), cafe: Cafe()).printMenu()

*/




//MARK: Combine Design Pattern

protocol MenuComponent
{
    func getName() throws -> String
    func getDetail()  throws -> String
    func isVegetarian()  throws -> Bool
    func getPrice()  throws -> Double
    
    func print()
    func addMenu(component: MenuComponent)  throws -> Void
    func removeMenu(component: MenuComponent)  throws -> Void
    func getChildComponent(at: Int)  throws -> MenuComponent
}

enum ComponentError: Error
{
    case unsuportedOperation
    case invalidIndex
}

extension MenuComponent  {
    
    func getName() throws -> String {
        throw ComponentError.unsuportedOperation
    }
    
    func getDetail() throws -> String {
           throw ComponentError.unsuportedOperation
    }
    
    func isVegetarian() throws -> Bool {
           throw ComponentError.unsuportedOperation
    }
    
    func getPrice() throws -> Double {
           throw ComponentError.unsuportedOperation
    }
    
  
    
    func addMenu(component: MenuComponent) throws -> Void {
           throw ComponentError.unsuportedOperation
    }
    
    func removeMenu(component: MenuComponent) throws -> Void {
           throw ComponentError.unsuportedOperation
    }
    
    func getChildComponent(at: Int) throws -> MenuComponent {
           throw ComponentError.unsuportedOperation
    }
}

extension MenuItem: MenuComponent {
    
    func getName() throws -> String {
        return self.name
    }
    
    func getDetail() throws -> String {
        return self.detail
    }
    
    func isVegetarian() throws -> Bool {
        self.vegetarian
    }
    
    func getPrice() throws -> Double {
        self.price
    }
    
    func print() {
        debugPrint(self.description)
    }
    
    func addMenu(component: MenuComponent) throws -> Void {
        throw ComponentError.unsuportedOperation
    }
    
    func removeMenu(component: MenuComponent) throws -> Void {
        throw ComponentError.unsuportedOperation
    }
    
    func getChildComponent(at: Int) throws -> MenuComponent {
        throw ComponentError.unsuportedOperation
    }
}

class RsturantMenu: MenuComponent {
    private let name: String
    private let detail: String
    
    private(set) var menuComponents = [MenuComponent]()
    
    init(name: String, detail: String) {
        self.name = name
        self.detail = detail
    }
    
    func getName() throws -> String {
        throw ComponentError.unsuportedOperation
    }
    
    func getDetail() throws -> String {
        throw ComponentError.unsuportedOperation
    }
    
    func isVegetarian() throws -> Bool {
        throw ComponentError.unsuportedOperation
    }
    
    func getPrice() throws -> Double {
        throw ComponentError.unsuportedOperation
    }
    
    func print() {
        debugPrint("\n")
        debugPrint("\(self.name)")
        debugPrint("\(self.detail)")
        debugPrint("-----------------Start \(name)----------------------")
        for component in menuComponents {
            component.print()
        }
        
        debugPrint("-----------------End \(name)----------------------")
    }
    
    func addMenu(component: MenuComponent) throws -> Void {
        self.menuComponents.append(component)
    }
    
    func removeMenu(component: MenuComponent) throws -> Void {
        throw ComponentError.unsuportedOperation
    }
    
    func getChildComponent(at index: Int) throws -> MenuComponent {
        if menuComponents.count > index {
            return self.menuComponents[index]
        } else {
            throw ComponentError.invalidIndex
        }
    }
}

protocol RsturantIterator {
    var hasNext: Bool {get}
    func next() -> MenuComponent?
}

protocol ResturantMenuProtocol {
    func createIterator() -> RsturantIterator
}

class RsturantMenuIterator: RsturantIterator {
    private var components: [MenuComponent]
    private var index: Int = 0
    init(components: [MenuComponent]) {
        self.components = components
    }
    var hasNext: Bool {
        return index < components.count
    }
    
    func next() -> MenuComponent? {
        if hasNext {
            let item = components[index]
            index += 1
            return item
        } else {
            return nil
        }
    }
}

class NotRsturantMenuIterator: RsturantIterator {
    var hasNext: Bool {
        return false
    }
    
    func next() -> MenuComponent? {
        return nil
    }
}

extension MenuItem: ResturantMenuProtocol {
    func createIterator() -> RsturantIterator {
        return NotRsturantMenuIterator()
    }
}

extension RsturantMenu: ResturantMenuProtocol {
    func createIterator() -> RsturantIterator {
        return RsturantMenuIterator(components: self.menuComponents)
    }
}


class ClientAndWaitress {
    typealias Menu = MenuComponent & ResturantMenuProtocol
    private let menuCard: Menu
    init(menu: Menu) {
        self.menuCard = menu
    }
    
    func printMenu() {
        self.menuCard.print()
        
        debugPrint("-----------------Start Vegetraian Menu----------------------")

        printVegetarianMenu(iterator: menuCard.createIterator())
        
        debugPrint("-----------------End Vegetraian Menu----------------------")

    }
    
    
    func printVegetarianMenu(iterator: RsturantIterator) {
        while iterator.hasNext {
            guard let item = iterator.next() as? Menu else
            { return }
            if let isVegi = try?item.isVegetarian(), isVegi {
                item.print()
            } else {
                printVegetarianMenu(iterator: item.createIterator())
            }
        }
    }
}

class MenuTestDrive {
    let menuClient: ClientAndWaitress?
    init?() {
        var mainMenu: RsturantMenu? = nil
        
        do {
            let pancakeMenu = RsturantMenu(name: "PANCAKE HOUSE MENU", detail: "Breakfast")
            let lunchMenu = RsturantMenu(name: "LUNCH MENU", detail: "Lunch")
            let dinnerMenu = RsturantMenu(name: "CAFFE MENU", detail: "Dinner")
            let dessertMenu = RsturantMenu(name: "DESSERT MENU", detail: "Dessert of course!")
            
            mainMenu = RsturantMenu(name: "ALL MENU", detail: "All menus combined.")
            
            try mainMenu?.addMenu(component: pancakeMenu)
            try mainMenu?.addMenu(component: lunchMenu)
            try mainMenu?.addMenu(component: dinnerMenu)
            
            let pancakeItem1 = MenuItem(name: "Pancake Item 1", detail: "Pandcake Description 1", vegetarian: true, price: 1.99)
            let pancakeItem2 = MenuItem(name: "Pancake Item 2", detail: "Pandcake Description 1", vegetarian: false, price: 1.99)
            let pancakeItem3 = MenuItem(name: "Pancake Item 3", detail: "Pandcake Description 1", vegetarian: true, price: 1.99)
            let pancakeItem4 = MenuItem(name: "Pancake Item 4", detail: "Pandcake Description 1", vegetarian: false, price: 1.99)
            
            try pancakeMenu.addMenu(component: pancakeItem1)
            try pancakeMenu.addMenu(component: pancakeItem2)
            try pancakeMenu.addMenu(component: pancakeItem3)
            try pancakeMenu.addMenu(component: pancakeItem4)
            
            
            let dinnerItem1 = MenuItem(name: "Dinner Item 1", detail: "Dinner Description 1", vegetarian: true, price: 1.99)
            let dinnerItem2 = MenuItem(name: "Dinner Item 2", detail: "Dinner Description 1", vegetarian: false, price: 1.99)
            let dinnerItem3 = MenuItem(name: "Dinner Item 3", detail: "Dinner Description 1", vegetarian: true, price: 1.99)
            let dinnerItem4 = MenuItem(name: "Dinner Item 4", detail: "Dinner Description 1", vegetarian: false, price: 1.99)
            
            try dinnerMenu.addMenu(component: dinnerItem1)
            try dinnerMenu.addMenu(component: dinnerItem2)
            try dinnerMenu.addMenu(component: dinnerItem3)
            try dinnerMenu.addMenu(component: dinnerItem4)
            
            let lunchItem1 = MenuItem(name: "Lunch Item 1", detail: "Lunch Description 1", vegetarian: true, price: 1.99)
            let lunchItem2 = MenuItem(name: "Lunch Item 2", detail: "Lunch Description 1", vegetarian: false, price: 1.99)
            let lunchItem3 = MenuItem(name: "Lunch Item 3", detail: "Lunch Description 1", vegetarian: true, price: 1.99)
            let lunchItem4 = MenuItem(name: "Lunch Item 4", detail: "Lunch Description 1", vegetarian: false, price: 1.99)
            
            try lunchMenu.addMenu(component: lunchItem1)
            try lunchMenu.addMenu(component: lunchItem2)
            try lunchMenu.addMenu(component: lunchItem3)
            try lunchMenu.addMenu(component: lunchItem4)
            
            try lunchMenu.addMenu(component: dessertMenu)

            
            let dessertItem1 = MenuItem(name: "Dessert Item 1", detail: "Dessert Description 1", vegetarian: true, price: 1.99)
            let dessertItem2 = MenuItem(name: "Dessert Item 2", detail: "Dessert Description 1", vegetarian: false, price: 1.99)
            let dessertItem3 = MenuItem(name: "Dessert Item 3", detail: "Dessert Description 1", vegetarian: true, price: 1.99)
            let dessertItem4 = MenuItem(name: "Dessert Item 4", detail: "Dessert Description 1", vegetarian: false, price: 1.99)
            
            try dessertMenu.addMenu(component: dessertItem1)
            try dessertMenu.addMenu(component: dessertItem2)
            try dessertMenu.addMenu(component: dessertItem3)
            try dessertMenu.addMenu(component: dessertItem4)
            
        } catch let error {
            debugPrint("\(error.localizedDescription)")
        }
        guard let mainMenu1 = mainMenu else {
            return nil
        }
        menuClient = ClientAndWaitress(menu: mainMenu1)
    }
}


let client = MenuTestDrive()?.menuClient
client?.printMenu()
