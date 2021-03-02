//
//  main.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/11.
//

import Foundation

/*
 1장 프로토콜 시작: Protocol.swift
 2장 타입 선택: Type.swift
 3장 확장: Extension.swift
 4장 제네릭: Generic.swift
 5장 객체지향 프로그래밍: OOP.swift
 6장 프로토콜지향 프로그래밍: POP.swift
 7장 스위프트에서 디자인 패턴 적용: DesignPattern-*.swift
 8장 사례 연구
*/

/// 사례 연구
// 로깅 서비스
// LoggerProfile
protocol LoggerProfile {
    var loggerProfileId: String {get}
    func writeLog(level: String, message: String)
}

extension LoggerProfile {
    func getCUrrentDataString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm"
        return dateFormatter.string(from: date)
    }
}

struct LoggerNull: LoggerProfile {
    let loggerProfileId = "hoffman.jon.logger.null"
    func writeLog(level: String, message: String) {
        // 아무 일도 하지 않는다.
    }
}

struct LoggerConsole: LoggerProfile {
    let loggerProfileId = "hoffman.jon.logger.console"
    func writeLog(level: String, message: String) {
        let now = getCUrrentDataString()
        print("\(now): \(level) - \(message)")
    }
}

// Logger Type
enum LogLevels: String {
    case Fatal
    case Error
    case Warn
    case Debug
    case Info
    
    static let allValues = [Fatal, Error, Warn, Debug, Info]
}

protocol Logger {
    static var loggers: [LogLevels: [LoggerProfile]] {get set}
    static func writeLog(logLevel: LogLevels, message: String)
}

