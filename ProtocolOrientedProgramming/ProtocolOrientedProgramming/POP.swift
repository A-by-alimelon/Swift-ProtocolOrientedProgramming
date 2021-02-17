//
//  POP.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/17.
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

var vehicles = [Vehicle]()
var vh1 = Amphibious()
var vh2 = Amphibious()
var vh3 = Tank()
var vh4 = Tank()

vehicles.append(vh1)
vehicles.append(vh2)
vehicles.append(vh3)
vehicles.append(vh4)

// 형 변환을 이용한 사용
for (index, vehicle) in vehicles.enumerated() {
    if let vehicle = vehicle as? AirVehicle {
        print("vehicle at \(index) is Air")
    }
    if let vehicle = vehicle as? LandVehicle {
        print("vehicle at \(index) is Land")
    }
    if let vehicle = vehicle as? SeaVehicle {
        print("vehicle at \(index) is Sea")
    }
}

// where절을 이용하여 사용
for (index, vehicle) in vehicles.enumerated() where vehicle is LandVehicle {
    let vh = vehicle as! LandVehicle
    if vh.landAttack {
        vh.doLandAttack()
    }
    if vh.landMovement {
        vh.doLandMovement()
    }
}

// 값 타입에서 변경사항을 유지하고 싶을 때
func takeHit<T: Vehicle>(vehicle: inout T) {
    vehicle.takeHit(amount: 10)
}

var tank = Tank()
takeHit(vehicle: &tank)
print(tank.hitPointsRemaining())
