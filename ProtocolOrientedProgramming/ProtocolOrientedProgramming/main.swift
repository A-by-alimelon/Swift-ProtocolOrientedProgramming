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

protocol LandVehicle: Vehicle {
    var landAttack: Bool {get}
    var landMovement: Bool {get}
    var landAttackRange: Int {get}
    
    func doLandAttack()
    func doLandMovement()
}

protocol SeaVehicle: Vehicle {
    var seaAttack: Bool {get}
    var seaMovement: Bool {get}
    var seaAttackRange: Int {get}
    
    func doSeaAttack()
    func doSeaMovement()
}

protocol AirVehicle: Vehicle {
    var airAttack: Bool {get}
    var airMovement: Bool {get}
    var airAttackRange: Int {get}
    
    func doAirAttack()
    func doAirMovement()
}

struct Tank: LandVehicle {
    var hitPoints = 68
    let landAttack = true
    let landMovement = true
    let landAttackRange = 5
    
    func doLandAttack() {
        print("Tank Attack")
    }
    
    func doLandMovement() {
        print("Tank Move")
    }
}

// 프로토콜 컴포지션 사용
struct Amphibious: LandVehicle, SeaVehicle {
    var hitPoints = 25
    let landAttackRange = 1
    let seaAttackRange = 1
    
    let landAttack = true
    let landMovement = true
    
    let seaAttack = true
    let seaMovement = true
    
    func doLandAttack() {
        print("Amphibious Land Attack")
    }
    
    func doLandMovement() {
        print("Amphibious Land Move")
    }
    
    func doSeaAttack() {
        print("Amphibious Sea Attack")
    }
    
    func doSeaMovement() {
        print("Amphibious Sea Move")
    }
}
