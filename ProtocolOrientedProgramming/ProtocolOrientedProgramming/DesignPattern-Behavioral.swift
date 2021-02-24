//
//  DesignPattern-Behavioral.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/24.
//

import Foundation

/// 행위
// 커맨드 패턴
// 계산기 만들기
protocol MathCommand {
    func exec(num1: Double, num2: Double) -> Double
}

// MathCommand를 채택하는 타입
struct AdditionCommand: MathCommand {
    func exec(num1: Double, num2: Double) -> Double {
        return num1 + num2
    }
}

struct SubtractionCommand: MathCommand {
    func exec(num1: Double, num2: Double) -> Double {
        return num1 - num2
    }
}

struct MultiplicationCommand: MathCommand {
    func exec(num1: Double, num2: Double) -> Double {
        return num1 * num2
    }
}

struct DivisionCommand: MathCommand {
    func exec(num1: Double, num2: Double) -> Double {
        return num1 / num2
    }
}

// 호출자
struct Calculator {
    func performCalculation(num1: Double, num2: Double, command: MathCommand) -> Double {
        return command.exec(num1: num1, num2: num2)
    }
}

var calc = Calculator()
var startValue = calc.performCalculation(num1: 25, num2: 10, command: SubtractionCommand())
print(startValue)
var answer = calc.performCalculation(num1: startValue, num2: 5, command: MultiplicationCommand())
print(answer)

// 스트래티지 패턴
protocol CompressionStrategy {
    func compressFiles(filePaths: [String])
}

struct ZipCompressionStrategy: CompressionStrategy {
    func compressFiles(filePaths: [String]) {
        print("Using Zip Compression")
    }
}

struct RarCompressionStrategy: CompressionStrategy {
    func compressFiles(filePaths: [String]) {
        print("Using RAR Compression")
    }
}

struct CompressContent {
    var strategy: CompressionStrategy
    
    func compressFiles(filePaths: [String]) {
        strategy.compressFiles(filePaths: filePaths)
    }
}

var filePaths = ["file1.txt", "file2.txt"]
var zip = ZipCompressionStrategy()
var rar = RarCompressionStrategy()

var compress = CompressContent(strategy: zip)
compress.compressFiles(filePaths: filePaths)

compress.strategy = rar
compress.compressFiles(filePaths: filePaths)

// 옵저버 패턴
// 1. NotificationCenter 이용
let NCNAME = "Notification Name"

class PostType {
    let nc = NotificationCenter.default
    
    func post() {
        nc.post(name: Notification.Name(NCNAME), object: nil)
    }
}

class ObserverType {
    let nc = NotificationCenter.default
    
    init() {
        nc.addObserver(self, selector: #selector(receiveNotification(notification:)), name: Notification.Name(NCNAME), object: nil)
    }
    
    @objc func receiveNotification(notification: Notification) {
        print("Notification Received")
    }
}

var postType = PostType()
var observerType = ObserverType()
postType.post()

// 2. protocol 이용
protocol ZombieObserver {
    func turnLeft()
    func turnRight()
    func seesUs()
}

class MyObserver: ZombieObserver {
    func turnLeft() {
        print("Zombie turned left, we move right")
    }
    
    func turnRight() {
        print("Zombie turned right, we move left")
    }
    
    func seesUs() {
        print("Zombie sees us, RUN!!!!")
    }
}

struct Zombie {
    var observer: ZombieObserver
    
    // 보통 observer의 함수를 호출할 때에는 새로운 쓰레드에서 한다!
    func turnZombieLeft() {
        // 왼쪽으로 돌고
        // 옵저버에게 알린다.
        observer.turnLeft()
    }
    
    func turnZombieRight() {
        // 오른쪽으로 돌고
        // 옵저버에게 알린다.
        observer.turnRight()
    }
    
    func spotHuman() {
        // 사람을 추적
        // 옵저버에게 알린다.
        observer.seesUs()
    }
}

var observer = MyObserver()
var zombie = Zombie(observer: observer)

zombie.turnZombieLeft()
zombie.spotHuman()
