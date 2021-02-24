//
//  main.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/11.
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
