//
//  main.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/11.
//

import Foundation

/// class
class MyClass {
    var oneProperty: String
    
    init(oneProperty: String) {
        self.oneProperty = oneProperty
    }
    
    func oneFunction() {
        
    }
}

/// struct
struct MyStruct {
    var oneProperty: String
    
    func oneFunction() {
        
    }
}

/// enum
enum Devices: String {
    case IPod = "iPod"
    case IPhone = "iPhone"
    case IPad = "iPad"
}

print(Devices.IPad.rawValue)

// case에 연관 값 저장
enum Devices2 {
    case IPod(model: Int, year: Int, memory: Int)
    case IPhone(model: String, memory: Int)
    case IPad(model: String, memory: Int)
}

var myPhone = Devices2.IPhone(model: "6", memory: 64)
var myTablet = Devices2.IPad(model: "Pro", memory: 128)

switch myPhone {
case .IPod(let model, _, let memory):
    print("iPod: \(model) \(memory)")
case .IPhone(let model, let memory):
    print("iPhone: \(model) \(memory)")
case .IPad(let model, let memory):
    print("iPad \(model) \(memory)")
}


// 연산 프로퍼티, 메소드가 있는 enum
enum Reindeer: String {
    case Dasher, Dancer, Prancer, Vixen, Comet, Cupid, Donner, Blitzen, Rudolph
    
    static var allCases: [Reindeer] {
        return [Dasher, Dancer, Prancer, Vixen, Comet, Cupid, Donner, Blitzen, Rudolph]
    }
    
    static func randomCase() -> Reindeer {
        let randomValue = Int(arc4random_uniform(UInt32(allCases.count)))
        return allCases[randomValue]
    }
}

enum BookFormat {
    case PaperBack(pageCount: Int, price: Double)
    case HardCover(pageCount: Int, price: Double)
    case PDF(pageCount: Int, price: Double)
    case EPub(pageCount: Int, price: Double)
    case Kindle(pageCount: Int, price: Double)
}

var paperBack = BookFormat.PaperBack(pageCount: 220, price: 39.99)

switch paperBack {
case .PaperBack(pageCount: let pageCount, price: let price):
    print("\(pageCount) - \(price)")
case .HardCover(pageCount: let pageCount, price: let price):
    print("\(pageCount) - \(price)")
case .PDF(pageCount: let pageCount, price: let price):
    print("\(pageCount) - \(price)")
case .EPub(pageCount: let pageCount, price: let price):
    print("\(pageCount) - \(price)")
case .Kindle(pageCount: let pageCount, price: let price):
    print("\(pageCount) - \(price)")
}

// 연관 값 검색을 용이하게 만들기
extension BookFormat {
    var pageCount: Int {
        switch self {
        case .PaperBack(pageCount: let pageCount, _):
            return pageCount
        case .HardCover(pageCount: let pageCount, _):
            return pageCount
        case .PDF(pageCount: let pageCount, _):
            return pageCount
        case .EPub(pageCount: let pageCount, _):
            return pageCount
        case .Kindle(pageCount: let pageCount, _):
            return pageCount
        }
    }
    
    var price: Double {
        switch self {
        case .PaperBack(_, price: let price):
            return price
        case .HardCover(_, price: let price):
            return price
        case .PDF(_, price: let price):
            return price
        case .EPub(_, price: let price):
            return price
        case .Kindle(_, price: let price):
            return price
        }
    }
}

print("\(paperBack.pageCount) - \(paperBack.price)")

extension BookFormat {
    func purchaseTogether(otherFormat: BookFormat) -> Double {
        return (self.price + otherFormat.price) * 0.80
    }
}

var pdf = BookFormat.PDF(pageCount: 180, price: 14.99)
var total = paperBack.purchaseTogether(otherFormat: pdf)

/// tuple
// 이름 없는 튜플
let mathGrade1 = ("Jon", 100)
let (name, score) = mathGrade1
print("\(name) - \(score)")

// 이름 있는 튜플
let mathGrade2 = (name: "Jon", grade: 100)
print("\(mathGrade2.name) - \(mathGrade2.grade)")

// 반환 값으로 사용
func calculateTip(billAmount: Double, tipPercent: Double) -> (tipAmount: Double, totalAmount: Double) {
    let tip = billAmount * (tipPercent/100)
    let total = billAmount + tip
    return (tipAmount: tip, totalAmount: total)
}

var tip = calculateTip(billAmount: 31.98, tipPercent: 20)
print("\(tip.tipAmount) - \(tip.totalAmount)")

// 별칭 부여
typealias myTuple = (tipAmount: Double, totalAmount: Double)

/// 값 타입과 참조 타입
// 값 타입
struct MyValueType {
    var name: String
    var assignment: String
    var grade: Int
}

// 참조 타입
class MyReferenceType {
    var name: String
    var assignment: String
    var grade: Int
    
    init(name: String, assignment: String, grade: Int) {
        self.name = name
        self.assignment = assignment
        self.grade = grade
    }
}

// 차이점
var val = MyValueType(name: "Jon", assignment: "Math Test 1", grade: 90)
var ref = MyReferenceType(name: "Jon", assignment: "Math Test 1", grade: 90)

func extraCreditValueType(val: MyValueType, extraCredit: Int) {
    var val = val
    val.grade += extraCredit
}

func extraCreditReferenceType(ref: MyReferenceType, extraCredit: Int) {
    ref.grade += extraCredit
}

extraCreditValueType(val: val, extraCredit: 5)
print("Value: \(val.name) - \(val.grade)")

extraCreditReferenceType(ref: ref, extraCredit: 5)
print("Reference: \(ref.name) - \(ref.grade)")

// 참조 타입에서의 문제
func getGradeForAssignment(assignment: MyReferenceType) {
    let num = Int(arc4random_uniform(20) + 80)
    assignment.grade = num
    print("Grade for \(assignment.name) is \(num)")
}

var mathGrades = [MyReferenceType]()
var students = ["Jon", "Kim", "Kailey", "Kara"]
var mathAssignment = MyReferenceType(name: "", assignment: "MathAssignment", grade: 0)

for student in students {
    mathAssignment.name = student
    getGradeForAssignment(assignment: mathAssignment)
    mathGrades.append(mathAssignment)
}

mathGrades.forEach {
    print("\($0.name): grade \($0.grade)")
}

print("==========================")

// 값 타입에서의 원본 값 변경
func getGradeForAssignment(assignment: inout MyValueType) {
    let num = Int(arc4random_uniform(20) + 80)
    assignment.grade = num
    print("Grade for \(assignment.name) is \(num)")
}

var mathGrades2 = [MyValueType]()
var students2 = ["Jon", "Kim", "Kailey", "Kara"]
var mathAssignment2 = MyValueType(name: "", assignment: "MathAssignment", grade: 0)

for student in students2 {
    mathAssignment2.name = student
    getGradeForAssignment(assignment: &mathAssignment2)
    mathGrades2.append(mathAssignment2)
}

mathGrades2.forEach {
    print("\($0.name): grade \($0.grade)")
}

/// 참조 타입 - 재귀적 데이터 타입
class LinkedListReferenceType {
    var value: String
    var next: LinkedListReferenceType?
    
    init(value: String) {
        self.value = value
    }
}

struct LinkedListValueType {
    var value: String
//    var next: LinkedListValueType? // error
}

/// 참조 타입 - 상속
class Animal {
    var numberOfLegs = 0
    
    func sleep() {
        print("zzzzz")
    }
    func walking() {
        print("Walking on \(numberOfLegs) legs")
    }
    func speaking() {
        print("No sound")
    }
}

class Biped: Animal {
    override init() {
        super.init()
        numberOfLegs = 2
    }
}

class Quadruped: Animal {
    override init() {
        super.init()
        numberOfLegs = 4
    }
}

class Dog: Quadruped {
    override func speaking() {
        print("Barking")
    }
}

/// 다이내믹 디스패치
// 런타임 오버헤드 줄이기 - final
final class MyFinalClass {} // 서브클래싱 불가

class MyClassWithFinalPropertyAndMethod {
    final func myFunc() {}
    final var myProperty = 0 // 오버라이드 불가 
}
