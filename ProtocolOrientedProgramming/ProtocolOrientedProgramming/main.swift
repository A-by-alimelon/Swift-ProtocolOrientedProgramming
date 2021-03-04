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

extension Logger {
    static func logLevelContainsProfile(logLevel: LogLevels, loggerProfile: LoggerProfile) -> Bool {
        if let logProfiles = loggers[logLevel] {
            for logProfile in logProfiles where logProfile.loggerProfileId == loggerProfile.loggerProfileId {
                return true
            }
        }
        return false
    }
    
    static func setLogLevel(logLevel: LogLevels, loggerProfile: LoggerProfile) {
        if let _ = loggers[logLevel] {
            if !logLevelContainsProfile(logLevel: logLevel, loggerProfile: loggerProfile) {
                loggers[logLevel]?.append(loggerProfile)
            }
        } else {
            var a = [LoggerProfile]()
            a.append(loggerProfile)
            loggers[logLevel] = a
        }
    }
    
    static func addLogProfileToAllLevels(defaultLoggerProfile: LoggerProfile) {
        for level in LogLevels.allValues {
            setLogLevel(logLevel: level, loggerProfile: defaultLoggerProfile)
        }
    }
    
    static func removeLogProfileFromLevel(logLevel: LogLevels, loggerProfile: LoggerProfile) {
        if var logProfiles = loggers[logLevel] {
            if let index = logProfiles.firstIndex(where: {$0.loggerProfileId == loggerProfile.loggerProfileId}) {
                logProfiles.remove(at: index)
            }
            loggers[logLevel] = logProfiles
        }
    }
    
    static func removeLogProfileFromAllLevels(loggerProfile: LoggerProfile) {
        for level in LogLevels.allValues {
            removeLogProfileFromLevel(logLevel: level, loggerProfile: loggerProfile)
        }
    }
    
    static func hasLoaggerForLevel(logLevel: LogLevels) -> Bool {
        guard let logProfiles = loggers[logLevel] else {
            return false
        }
        return !logProfiles.isEmpty
    }
}

// 커맨드 패턴 사용 
struct MyLogger: Logger {
    static var loggers = [LogLevels : [LoggerProfile]]()
    
    static func writeLog(logLevel: LogLevels, message: String) {
        guard hasLoaggerForLevel(logLevel: logLevel) else {
            print("No logger")
            return
        }
        if let logProfiles = loggers[logLevel] {
            for logProfile in logProfiles {
                logProfile.writeLog(level: logLevel.rawValue, message: message)
            }
        }
    }
}

MyLogger.addLogProfileToAllLevels(defaultLoggerProfile: LoggerConsole())
MyLogger.writeLog(logLevel: LogLevels.Debug, message: "Debug Message 1")
MyLogger.writeLog(logLevel: LogLevels.Error, message: "Error Message 1")

// 데이터 접근 계층
// 데이터 모델 계층
typealias TeamData = (teamId: Int64?, city: String?, nickName: String?, abbreviation: String?)
typealias PlayerData = (playerId: Int64?, firstName: String?, lastName: String?, number: Int?, teamId: Int64?, position: Positions?)

enum Positions: String {
    case pitcher = "Pitcher"
    case catcher = "Catcher"
    case firstBase = "First Base"
    case secondBase = "Second Base"
    case thirdBase = "Third Base"
    case shortstop = "Shortstop"
    case leftField = "Left Field"
    case centerField = "Center Field"
    case rightField = "Right Field"
    case designatedHitter = "Designated Hitter"
}
