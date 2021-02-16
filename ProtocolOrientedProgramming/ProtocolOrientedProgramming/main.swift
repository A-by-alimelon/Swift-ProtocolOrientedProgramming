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

// 이동수단의 슈퍼클래스
class Vehicle {
    fileprivate var vehicleTypes = [TerrainType]()
    fileprivate var vehicleAttackTypes = [TerrainType]()
    fileprivate var vehicleMovementTypes = [TerrainType]()
    fileprivate var landAttackRange = -1
    fileprivate var seaAttackRange = -1
    fileprivate var airAttackRange = -1
    fileprivate var hitPoints = 0
    
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
    func isAlive() -> Bool { return hitPoints > 0 ? true : false }
}

// land type 서브클래스
class Tank: Vehicle {
    override init() {
        super.init()
        vehicleTypes = [.land]
        vehicleAttackTypes = [.land]
        vehicleMovementTypes = [.land]
        landAttackRange = 5
        hitPoints = 68
    }
    
    override func doLandAttack() {
        print("Tank Attack")
    }
    
    override func doLandMovement() {
        print("Tank Move")
    }
}

// land & sea type 서브클래스
class Amphibious: Vehicle {
    override init() {
        super.init()
        vehicleTypes = [.land, .sea]
        vehicleAttackTypes = [.land, .sea]
        vehicleMovementTypes = [.land, .sea]
        
        landAttackRange = 1
        seaAttackRange = 1
        
        hitPoints = 25
    }
    
    override func doLandAttack() {
        print("Amphibious Land Attack")
    }
    
    override func doLandMovement() {
        print("Amphibious Land Move")
    }
    
    override func doSeaAttack() {
        print("Amphibious Sea Attack")
    }
    
    override func doSeaMovement() {
        print("Amphibious Sea Move")
    }
}

// land & sea & air type 서브클래스
class Transformer: Vehicle {
    override init() {
        super.init()
        vehicleTypes = [.land, .air, .sea]
        vehicleAttackTypes = [.land, .air, .sea]
        vehicleMovementTypes = [.land, .air, .sea]
        
        landAttackRange = 7
        seaAttackRange = 10
        airAttackRange = 12
        
        hitPoints = 75
    }
    
    override func doLandAttack() {
        print("Tranformer Land Attack")
    }
    
    override func doLandMovement() {
        print("Tranformer Land Move")
    }
    
    override func doSeaAttack() {
        print("Tranformer Sea Attack")
    }
    
    override func doSeaMovement() {
        print("Tranformer Sea Move")
    }
    
    override func doAirAttack() {
        print("Transformer Air Attack")
    }
    
    override func doAirMovement() {
        print("Tranformer Air Move")
    }
}
