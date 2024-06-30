import UIKit

var str = "Observer Pattern"

//Subject: A Publisher who transmit information. Its other name could be Transmitter, Publisher, Observeable & Subject.
//Observer: A Subscriber who subscrib publisher to recieve information. Its other name could be Reciever, Subscriber, Listiner & Observer.
//Example of Subsject: Radio brodcastor, GPS satelites, Weather brodcastor etc...
//Example of Observer: FM raidio, GPS receiver mobile, etc..

protocol Subject {
    func registor(observer: Observer)
    func remove(observer: Observer)
    func notify()
}

protocol Observer: class {
    func update(info: Any)
}


struct WeatherData: CustomStringConvertible {
    let temperature: Double
    let humidity: Double
    let pressure: Double
    
    var description: String {
        return """
            Temperature: \(temperature)
            Humidity: \(humidity)
            Pressure: \(pressure)
        """
    }
}

class WeatherStation: Subject {
    var weatherData: WeatherData {
        didSet {
            notify()
        }
    }
    var observers = [Observer]()

    init(weatherData: WeatherData) {
        self.weatherData = weatherData
        notify()
    }
    
    func registor(observer: Observer) {
        self.observers.append(observer)
    }
    
    func remove(observer: Observer) {
        guard let index = self.observers.firstIndex(where: { (obj) -> Bool in
            return observer === obj
        }) else {
            return
        }
        
        self.observers.remove(at: index)
    }
    
    func notify() {
        debugPrint("observers = \(self.observers.count)")
        for observer in self.observers {
            observer.update(info: self.weatherData)
        }
    }
}




protocol DisplayProtocol {
    func display()
}

class CurrentConditionDisplay: Observer, DisplayProtocol {
    private var weatherData: WeatherData?
    init(_ subject: Subject? = nil) {
        subject?.registor(observer: self)
    }
    
    func update(info: Any) {
        self.weatherData = info as? WeatherData
        self.display()
    }
    
    func display() {
        guard let weatherData = self.weatherData else { return }
        debugPrint("""
            Weather Current Condition Display
            \(weatherData.description)
        """)
    }
}

class StatisticsDisplay: Observer, DisplayProtocol {
    private var weatherStatistics = [WeatherData]()

    init(_ subject: Subject? = nil) {
        subject?.registor(observer: self)
    }
    
    func update(info: Any) {
        if let weatherData = info as? WeatherData {
            //Keep adding previous data
            self.weatherStatistics.append(weatherData)
            display()
        }
    }
    
    func display() {
        //Display every time new data along with past data.
        var count = 0
        for info in self.weatherStatistics {
            debugPrint("""
                Weather Statistics Display for info \(count + 1)
                Teamperature: \(info.temperature)
                Humidity: \(info.humidity)
                Pressure: \(info.pressure)
            """)
            count += 1
        }
    }
}

class ForcastDisplay: Observer, DisplayProtocol {
    private var weatherDatas = Stack<WeatherData>(max: 10)

    init(_ subject: Subject? = nil) {
        subject?.registor(observer: self)
    }
    
    func update(info: Any) {
        if let data = info as? WeatherData {
            do {
                //Keep adding previous data
                try weatherDatas.push(data)
                display()
            } catch let error {
                debugPrint("error: \(error.localizedDescription)")
            }
        }
    }

    func display() {
        //Display every time new data along with past data.
        var count = 0
        for data in self.weatherDatas {
            debugPrint("""
                 Weather Forcast Display for weather Data \(count + 1)
                 Teamperature: \(data.temperature)
                 Humidity: \(data.humidity)
                 Pressure: \(data.pressure)
             """)
            count += 1
        }
    }
}

enum StackException: Error, CustomStringConvertible {
    case overflow
    case underflow
    
    var description: String {
        switch self {
        case .overflow:
            return "Stack Over Flow"
        case .underflow:
            return "Stack Under Flow"
        }
    }
}

struct Stack<T>:Sequence, IteratorProtocol {
    private var maxCount: Int = 0
    private var items = [T]()
    init(max: Int) {
        self.maxCount = max
    }
    
    mutating func push(_ element: T) throws  -> Void {
        if self.items.count == maxCount {
            throw StackException.overflow
        } else {
            self.items.append(element)
        }
    }
    
    mutating func pop() throws -> T {
        if self.items.count == 0 {
            throw StackException.underflow
        } else {
            return self.items.removeLast()
        }
    }
    
    var count: Int {
        return self.items.count
    }
    
    mutating func next() -> T? {
        return try? self.pop()
    }
}



/*
 ---------------------------------------iOS in build notification center supported observer pattern-----------------------------------------------
*/
//MARK: iOS in build observer pattern using NotificationCenter.
extension Notification.Name {
    static let WeatherDataChanged = Notification.Name(rawValue: "WeatherDataChanged")
}

class iOSWeatherStation {
    var weatherData: WeatherData? {
        // property observer
        didSet {
            notify()
        }
    }
    
    private func notify() {
        guard let weatherData = weatherData else {
            return
        }
        NotificationCenter.default.post(name: .WeatherDataChanged, object: weatherData)
    }
}


class IOSCurrentConditionDisplay: DisplayProtocol {
    private var weatherData: WeatherData?
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.update(_:)), name: .WeatherDataChanged, object: nil)
    }
    
    @objc func update(_ notification: NSNotification) {
        guard let weatherData = notification.object as? WeatherData else { return }
        self.weatherData = weatherData
        self.display()
    }
    
    func display() {
        guard let weatherData = self.weatherData else { return }
        debugPrint("""
            iOS Weather Current Condition Display
            \(weatherData.description)
        """)
    }
}

/*
 ---------------------------------------Test observer pattern-----------------------------------------------
*/
//MARK: Test Observer Pattern
class TestWeatherStation {
    var weatherData: WeatherData
    var station: WeatherStation
    var iosStation: iOSWeatherStation
    var currentDisplay: CurrentConditionDisplay
    var forcastDisplay: ForcastDisplay
    var statisticsDisplay: StatisticsDisplay
    var displayers = [DisplayProtocol]()
    let iOSCurrentConditionDisplay: IOSCurrentConditionDisplay
    init() {
        weatherData = WeatherData(temperature: 23234, humidity: 453, pressure: 3534)
        station = WeatherStation(weatherData: weatherData)
        
        currentDisplay = CurrentConditionDisplay(station)
        forcastDisplay = ForcastDisplay(station)
        statisticsDisplay = StatisticsDisplay(station)
        
        displayers.append(currentDisplay)
        displayers.append(forcastDisplay)
        displayers.append(statisticsDisplay)
        
        iosStation = iOSWeatherStation()
        iOSCurrentConditionDisplay = IOSCurrentConditionDisplay()
        iosStation.weatherData = weatherData


//        station.remove(observer: currentDisplay)
        
        
        checkWithStaticData()
//        displayers.append(currentDisplay)
 
    }
    
    func displayWeatherInfo() {
        debugPrint("--------------------Start \(station.observers.count)-----------------------------------")
        for observer in displayers {
            observer.display()
        }
        debugPrint("--------------------End \(station.observers.count)-----------------------------------")
    }
    
    func testWeather(info: WeatherData) {
        station.weatherData = info
        iosStation.weatherData = info
    }
    
    func checkWithStaticData() {
        self.displayWeatherInfo()

        let x = WeatherData(temperature: 35, humidity: 100, pressure: 70)
        testWeather(info: x)
        self.displayWeatherInfo()

        let y = WeatherData(temperature: 36, humidity: 103, pressure: 75)
        testWeather(info: y)
        self.displayWeatherInfo()

        let z = WeatherData(temperature: 37, humidity: 105, pressure: 78)
        testWeather(info: z)
        self.displayWeatherInfo()

    }
}

let testWeatherStation = TestWeatherStation()
