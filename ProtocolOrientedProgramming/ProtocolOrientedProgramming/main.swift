//
//  main.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/11.
//

import Foundation

fileprivate protocol FullName {
    var firstName: String {get set}
    var lastName: String {get set}
    func getFullName() -> String
    
    // 값 타입에서 메소드가 자신이 속한 인스턴스를 변경할 경우
    mutating func changeName()
}

/// 선택 가능한 프로퍼티 및 메소드를 가진 프로토콜
@objc fileprivate protocol Phone {
    var phoneNumber: String {get set}
    @objc optional var emailAddress: String {get set}
    func dialNumber()
    @objc optional func getEmail()
}

/// 프로토콜 상속
fileprivate protocol Person: FullName {
    var age: Int {get set}
}

fileprivate struct Student: Person {
    var firstName: String
    var lastName: String
    var age: Int
    
    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
    
    mutating func changeName() {
        self.lastName = "홍"
    }
}

/// 프로토콜을 타입으로 사용
fileprivate protocol Human {
    var firstName: String {get set}
    var lastName: String {get set}
    var birthDate: Date {get set}
    var profession: String {get}
    init(firstName: String, lastName: String, birthDate: Date)
}

fileprivate func updateHuman(human: Human) -> Human {
    var newHuman: Human = human
    //human 갱신
    return newHuman
}

fileprivate var humanArray = [Human]()
fileprivate var humanDict = [String: Human]()

struct SwiftProgrammer: Human {
    var firstName: String
    var lastName: String
    var birthDate: Date
    var profession: String = ""
    
    init(firstName: String, lastName: String, birthDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
}

struct FootballPlayer: Human {
    var firstName: String
    var lastName: String
    var birthDate: Date
    var profession: String = ""
    
    init(firstName: String, lastName: String, birthDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
    }
}

fileprivate var myHuman: Human
myHuman = SwiftProgrammer(firstName: "Jon", lastName: "Hoffman", birthDate: Date())
myHuman = FootballPlayer(firstName: "Dan", lastName: "Marino", birthDate: Date())
humanArray.append(SwiftProgrammer(firstName: "성주", lastName: "문", birthDate: Date()))
humanArray.append(FootballPlayer(firstName: "성주", lastName: "문", birthDate: Date()))

/// 프로토콜 형변환
// is로 확인
if myHuman is SwiftProgrammer {
    print("\(myHuman.firstName) is a Swift Programmer")
}

for human in humanArray where human is SwiftProgrammer {
    print("\(human.firstName) is a Swift Programmer")
}

// as로 형 변환
if let _ = myHuman as? FootballPlayer {
    print("\(myHuman.firstName) is a Football Player")
}

/// 연관 타입
fileprivate protocol Queue {
    associatedtype QueueType
    mutating func addItem(item: QueueType)
    mutating func getItem() -> QueueType?
    func count() -> Int
}

fileprivate struct IntQueue: Queue {
    var items = [Int]()
    
    mutating func addItem(item: Int) {
        items.append(item)
    }
    
    mutating func getItem() -> Int? {
        if items.count > 0 {
            return items.remove(at: 0)
        } else {
            return nil
        }
    }
    
    func count() -> Int {
        return items.count
    }
}

/// 델리게이션
protocol DisplayNameDelegate {
    func displayName(name: String)
}

struct DPerson {
    var displayNameDelegate: DisplayNameDelegate
    var firstName = "" {
        didSet {
            displayNameDelegate.displayName(name: getFullName())
        }
    }
    var lastName = "" {
        didSet {
            displayNameDelegate.displayName(name: getFullName())
        }
    }
    
    init(displayNameDelegate: DisplayNameDelegate) {
        self.displayNameDelegate = displayNameDelegate
    }
    
    func getFullName() -> String {
        return "\(firstName) \(lastName)"
    }
}

struct MyDisplayNameDelegate: DisplayNameDelegate {
    func displayName(name: String) {
        print("Name: \(name)")
    }
}

var displayDelegate = MyDisplayNameDelegate()
var dPerson = DPerson(displayNameDelegate: displayDelegate)
dPerson.firstName = "Jon"
dPerson.lastName = "Hoffman"

/// 프로토콜 설계
// 로봇의 움직임에 대한 프로토콜 정의
protocol RobotMovement {
    func forward(speedPercent: Double)
    func reverse(speedPercent: Double)
    func left(speedPercent: Double)
    func right(speedPercent: Double)
    func stop()
}

protocol RobotMovementThreeDimensions: RobotMovement {
    func up(speedPercent: Double)
    func down(speedPercent: Double)
}

// 로봇에 부착할 수 있는 센서 프로토콜 정의
protocol Sensor {
    var sensorType: String {get}
    var sensorName: String {get set}
    
    init(sensorName: String)
    func pollSensor()
}

protocol EnviromentSensor: Sensor {
    func currentTemperature() -> Double
    func currentHumidity() -> Double
}

protocol RangeSensor: Sensor {
    // 특정 거리 내에 있으면 클로저를 호출할 예정
    func setRangeNotification(rangeCentimeter: Double, rangeNotification: () -> Void)
    func currentRange() -> Double
}

protocol DisplaySensor: Sensor {
    func displayMessage(message: String)
}

protocol WirelessSensor: Sensor {
    // 메세지가 들어오면 클로저를 호출할 예정
    func setMessageReceivedNotification(messageNotification:(String) -> Void)
    func messageSend(message: String)
}

// 로봇의 기본 요구사항에 대한 프로토콜 정의
protocol Robot {
    var name: String {get set}
    var robotMovement: RobotMovement {get set}
    var sensors: [Sensor] {get}
    
    init(name: String, robotMovement: RobotMovement)
    func addSensor(sensor: Sensor)
    func pollSensors()
}
