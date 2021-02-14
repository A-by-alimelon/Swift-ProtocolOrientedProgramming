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
