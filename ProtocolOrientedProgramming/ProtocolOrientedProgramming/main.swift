//
//  main.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/11.
//

import Foundation

/// 객체지향 프로그래밍
enum TerrainType {
    case land
    case sea
    case air
}

class Vehicle {
    var vehicleTypes = [TerrainType]()
    var vehicleAttackTypes = [TerrainType]()
    var vehicleMovementTypes = [TerrainType]()
    var landArrackRange = -1
    var seaAttackRange = -1
    var airAttackRange = -1
    var hitPoints = 0
    
    func isVehicleType(type: TerrainType) -> Bool {
        return vehicleTypes.contains(type)
    }
    
    func canVehicleAttack(type: TerrainType) -> Bool {
        return vehicleAttackTypes.contains(type)
    }
    
    func canVehicleMove(type: TerrainType) -> Bool {
        return vehicleMovementTypes.contains(type)
    }
    
    func doLandAttack() {}
    func doLandMovement() {}
    
    func doSeaAttack() {}
    func doSeaMovement() {}
    
    func doAirAttack() {}
    func doAirMovement() {}
    
    func takeHit(amount: Int) { hitPoints -= amount }
    func hitPointsRemaining() -> Int { return hitPoints }
    func isAlive() -> Bool { return hitPoints > 0 ? true: false }
}
