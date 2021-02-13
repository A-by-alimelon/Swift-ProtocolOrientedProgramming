//
//  main.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/11.
//

import Foundation

// class
class MyClass {
    var oneProperty: String
    
    init(oneProperty: String) {
        self.oneProperty = oneProperty
    }
    
    func oneFunction() {
        
    }
}

// struct
struct MyStruct {
    var oneProperty: String
    
    func oneFunction() {
        
    }
}

// enum
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

var paperBack2 = BookFormat.PaperBack(pageCount: 420, price: 59.99)
print("\(paperBack2.pageCount) - \(paperBack2.price)")
