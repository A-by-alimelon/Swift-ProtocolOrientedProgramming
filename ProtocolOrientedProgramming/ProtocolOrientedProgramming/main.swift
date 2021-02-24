//
//  main.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/11.
//

import Foundation
/// 디자인 패턴
/// 생성
// 싱글턴 패턴
class MySingleton {
    static let sharedInstance = MySingleton() // 정적 상수
    var number = 0
    private init() {} // 추가 인스턴스화 방지
}

var singleA = MySingleton.sharedInstance // 이 때 생성
var singleB = MySingleton.sharedInstance
var singleC = MySingleton.sharedInstance
singleB.number = 2
print(singleA.number)
print(singleB.number)
print(singleC.number)
singleC.number = 3
print(singleA.number)
print(singleB.number)
print(singleC.number)

// 빌더 패턴
struct BurgerOld {
    var name: String
    var patties: Int
    var bacon: Bool
    var cheese: Bool
    var pickles: Bool
    var ketchup: Bool
    var mustard: Bool
    var lettuce: Bool
    var tomato: Bool
    
    init(name: String, patties: Int, bacon: Bool, cheese: Bool, pickles: Bool, ketchup: Bool, mustard: Bool, lettuce: Bool, tomato: Bool) {
        self.name = name
        self.patties = patties
        self.bacon = bacon
        self.cheese = cheese
        self.pickles = pickles
        self.ketchup = ketchup
        self.mustard = mustard
        self.lettuce = lettuce
        self.tomato = tomato
    } // 아주 복잡한 초기화 코드
}

var burgerOld = BurgerOld(name: "Hamburger", patties: 1, bacon: false, cheese: false, pickles: false, ketchup: false, mustard: false, lettuce: false, tomato: false)
var cheeseBurger = BurgerOld(name: "Cheeseburger", patties: 1, bacon: false, cheese: true, pickles: true, ketchup: true, mustard: true, lettuce: false, tomato: false)

// 여러 빌더 타입을 정의하는 방법
protocol BurgerBuilder {
    var name: String {get}
    var patties: Int {get}
    var bacon: Bool {get}
    var cheese: Bool {get}
    var pickles: Bool {get}
    var ketchup: Bool {get}
    var mustard: Bool {get}
    var lettuce: Bool {get}
    var tomato: Bool {get}
}

struct HamburgerBuilder: BurgerBuilder {
    let name = "Burger"
    let patties = 1
    let bacon = false
    let cheese = false
    let pickles = true
    let ketchup = true
    let mustard = true
    let lettuce = false
    let tomato = false
}

struct CheeseBurgerBuilder: BurgerBuilder {
    let name = "CheeseBurger"
    let patties = 1
    let bacon = false
    let cheese = true
    let pickles = true
    let ketchup = true
    let mustard = true
    let lettuce = false
    let tomato = true
}

struct Burger {
    var name: String
    var patties: Int
    var bacon: Bool
    var cheese: Bool
    var pickles: Bool
    var ketchup: Bool
    var mustard: Bool
    var lettuce: Bool
    var tomato: Bool
    
    init(builder: BurgerBuilder) {
        self.name = builder.name
        self.patties = builder.patties
        self.bacon = builder.bacon
        self.cheese = builder.cheese
        self.pickles = builder.pickles
        self.ketchup = builder.ketchup
        self.mustard = builder.mustard
        self.lettuce = builder.lettuce
        self.tomato = builder.tomato
    }
    
    func showBurger() {
        print("Name:    \(name)")
        print("Patties: \(patties)")
        print("Bacon:   \(bacon)")
        print("Cheese:  \(cheese)")
        print("Pickles: \(pickles)")
        print("Ketchup: \(ketchup)")
        print("Mustard: \(mustard)")
        print("Lettuce: \(lettuce)")
        print("Tomato: \(tomato)")
    }
}

var myBurger = Burger(builder: HamburgerBuilder())
myBurger.showBurger()

var myCheeseBurgerBuilder = CheeseBurgerBuilder()
var myCheeseBurger = Burger(builder: myCheeseBurgerBuilder)
print()
myCheeseBurger.tomato = false
myCheeseBurger.showBurger()

// 단일 빌더 타입을 이용하는 방법
struct SingleBurgerBuilder {
    var name = "Burger"
    var patties = 1
    var bacon = false
    var cheese = false
    var pickles = true
    var ketchup = true
    var mustard = true
    var lettuce = false
    var tomato = false
    
    mutating func setPatties(choice: Int) { self.patties = choice }
    mutating func setBacon(choice: Bool) { self.bacon = choice }
    mutating func setCheese(choice: Bool) { self.cheese = choice }
    mutating func setPickles(choice: Bool) { self.pickles = choice }
    mutating func setKetchup(choice: Bool) { self.ketchup = choice }
    mutating func setMustard(choice: Bool) { self.mustard = choice }
    mutating func setLettuce(choice: Bool) { self.lettuce = choice }
    mutating func setTomato(choice: Bool) { self.tomato = choice }
    
    func buildBurgerOld(name: String) -> BurgerOld {
        return BurgerOld(name: name, patties: patties, bacon: bacon, cheese: cheese, pickles: pickles, ketchup: ketchup, mustard: mustard, lettuce: lettuce, tomato: tomato)
    }
}

var singleBurgerBuilder = SingleBurgerBuilder()
singleBurgerBuilder.setCheese(choice: true)
singleBurgerBuilder.setBacon(choice: true)
var jonBurger = singleBurgerBuilder.buildBurgerOld(name: "Jon's Burger")

// 팩토리 메소드 패턴
protocol TextValidation {
    var regExFindMatchString: String {get}
    var validationMessage: String {get}
}

extension TextValidation {
    var regExMatchingString: String {
        get {
            return regExFindMatchString + "$"
        }
    }
    
    func validateString(str: String) -> Bool {
        if let _ = str.range(of: regExMatchingString, options: .regularExpression) {
            return true
        } else {
            return false
        }
    }
    
    func getMatchingString(str: String) -> String? {
        if let newMatch = str.range(of: regExFindMatchString, options: .regularExpression) {
            return String(str[newMatch])
        } else {
            return nil
        }
    }
}

class AlphaValidation: TextValidation {
    static let sharedInstance = AlphaValidation()
    private init() {}
    let regExFindMatchString = "^[a-zA-Z]{0,10}"
    let validationMessage = "Can only contain Alpha characters"
}

class AlphaNumericValidation: TextValidation {
    static let sharedInstance = AlphaNumericValidation()
    private init() {}
    
    let regExFindMatchString = "^[a-zA-Z0-9]{0,10}"
    let validationMessage = "Can only contain Alpha Numeric characters"
}

class NumericValidation: TextValidation {
    static let sharedInstance = NumericValidation()
    private init() {}
    
    let regExFindMatchString = "^[0-9]{0,10}"
    let validationMessage = "Can only contain Numeric characters"
}

// 인자 값에 따라 해당되는 textValidation을 return 하는 메소드
func getValidator(alphaCharacters: Bool, numericCharacters: Bool) -> TextValidation? {
    if alphaCharacters && numericCharacters {
        return AlphaNumericValidation.sharedInstance
    } else if alphaCharacters && !numericCharacters {
        return AlphaValidation.sharedInstance
    } else if !alphaCharacters && numericCharacters {
        return NumericValidation.sharedInstance
    } else {
        return nil
    }
}

print()
var str = "abc123"
var validation1 = getValidator(alphaCharacters: true, numericCharacters: false)
print("String validated: \(validation1?.validateString(str: str))")

var validation2 = getValidator(alphaCharacters: true, numericCharacters: true)
print("String validated: \(validation2?.validateString(str: str))")

/// 구조
// 브리지 패턴
protocol Message {
    var messageString: String {get set}
    init(messageString: String)
    func prepareMessage()
}

// 메세지를 보내기 전에 검증하는 요구 사항 추가
protocol Sender {
    var message: Message? {get set}
    func sendMessage()
    func verifyMessage()
    
}

class PlainTextMessage: Message {
    var messageString: String
    
    required init(messageString: String) {
        self.messageString = messageString
    }
    
    func prepareMessage() {
        // 아무것도 안함
    }
}

class DESEncyptedMessage: Message {
    var messageString: String
    
    required init(messageString: String) {
        self.messageString = messageString
    }
    
    func prepareMessage() {
        // 암호화한 메시지 생성
        self.messageString = "DES: " + self.messageString
    }
}

class EmailSender: Sender {
    var message: Message?
    
    func sendMessage() {
        print("Sending through E-Mail:")
        print(" \(message!.messageString)")
    }
    
    func verifyMessage() {
        print("Verifying E-Mail message")
    }
}

class SMSSender: Sender {
    var message: Message?
    
    func sendMessage() {
        print("Sending through SMS: ")
        print(" \(message!.messageString)")
    }
    
    func verifyMessage() {
        print("Verifying SMS message")
    }
}

var myMessage = PlainTextMessage(messageString: "Plain Text Message")
myMessage.prepareMessage()
var sender = SMSSender()
sender.message = myMessage
sender.verifyMessage()
sender.sendMessage()

// 위의 작업 단위를 하나로 묶는 브릿지 타입 생성
    struct MessageBridge {
        static func sendMessage(message: Message, sender: Sender) {
            var sender = sender
            message.prepareMessage()
            sender.message = message
            sender.verifyMessage()
            sender.sendMessage()
        }
    }


