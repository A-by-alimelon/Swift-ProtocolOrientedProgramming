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

