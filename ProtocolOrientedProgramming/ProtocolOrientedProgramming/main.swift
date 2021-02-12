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

// 선택 가능한 프로퍼티 및 메소드를 가진 프로토콜
@objc fileprivate protocol Phone {
    var phoneNumber: String {get set}
    @objc optional var emailAddress: String {get set}
    func dialNumber()
    @objc optional func getEmail()
}

// 프로토콜 상속
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

// 프로토콜을 타입으로 사용
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
