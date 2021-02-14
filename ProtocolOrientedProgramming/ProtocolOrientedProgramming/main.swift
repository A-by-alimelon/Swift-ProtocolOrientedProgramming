//
//  main.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/11.
//

import Foundation

/// 확장
// 메소드 확장
extension String {
    func getFirstChar() -> Character? {
        guard count > 0 else {
            return nil
        }
        return self[startIndex]
    }
}

var myString = "This is a test"
print(myString.getFirstChar())

// subscript 추가
extension String {
    subscript(r: CountableClosedRange<Int>) -> String {
        get {
            let start = index(self.startIndex, offsetBy: r.lowerBound)
            let end = index(self.startIndex, offsetBy: r.upperBound)
            return String(self[start..<end])
        }
    }
}

// 기본 타입 확장
extension Int {
    func squared() -> Int {
        return self * self
    }
}

print(21.squared())

extension Double {
    func currencyString() -> String {
        let divisor = pow(10.0, 2.0)
        let num = (self * divisor).rounded()
        return "$\(num)"
    }
}

extension Int {
    var mySquared: Int {
        return self * self
    }
}

/// 프로토콜 확장
extension Collection {
    func evenElements() -> [Iterator.Element] {
        var index = startIndex
        var result: [Iterator.Element] = []
        var i = 0
        repeat {
            if i % 2 == 0 {
                result.append(self[index])
            }
            index = self.index(after: index)
            i += 1
        } while index != endIndex
        return result
    }
    
    func myShuffle() -> [Iterator.Element] {
        return sorted() { left, right in
            return arc4random() < arc4random()
        }
    }
}

var origArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

var newArray = origArray.evenElements()
var ranArray = origArray.myShuffle()

var origDict = [1: "One", 2: "Two", 3: "Three", 4: "Four"]
var returnElements = origDict.evenElements() // dictionary는 순서가 없기 때문에 원하는대로 동작하지 않음

for item in returnElements {
    print(item)
}

// 확장 시 제약 추가
extension Collection where Self: ExpressibleByArrayLiteral {
    
}

extension Collection where Iterator.Element: Comparable {
    
}
