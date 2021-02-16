//
//  main.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/11.
//

import Foundation

/// 프로토콜지향 프로그래밍
protocol Vehicle {
    var hitPoints: Int {get set}
}

// 모든 이동수단에서 같은 기능을 하는 메소드를 확장으로 구현
extension Vehicle {
    mutating func takeHit(amount: Int) {
        hitPoints -= amount
    }
    
    func hitPointsRemaining() -> Int {
        return hitPoints
    }
    
    func isAlive() -> Bool {
        return hitPoints > 0 ? true : false
    }
}
