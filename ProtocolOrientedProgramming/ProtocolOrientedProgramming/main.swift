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

// 데이터 도우미 계층
enum DataAccessError: Error {
    case datastoreConnectionError
    case insertError
    case deleteError
    case searchError
    case nilInData
}

protocol DataHelper {
    associatedtype T
    static func insert(_ item: T) throws -> Int64?
    static func delete(_ item: T) throws -> Void
    static func findAll() throws -> [T]?
}

struct TeamDataHelper: DataHelper {
    typealias T = TeamData
    static var teamData: [T] = []
    
    static func insert(_ item: TeamData) throws -> Int64? {
        guard item.teamId != nil && item.city != nil && item.nickName != nil && item.abbreviation != nil else {
            throw DataAccessError.nilInData
        }
        
        teamData.append(item)
        return item.teamId
    }
    
    static func delete(_ item: TeamData) throws {
        guard let id = item.teamId else {
            throw DataAccessError.nilInData
        }
        
        let teamArray = teamData
        for (index, team) in teamArray.enumerated() where team.teamId == id {
            teamData.remove(at: index)
            return
        }
        throw DataAccessError.deleteError
    }
    
    static func findAll() throws -> [TeamData]? {
        return teamData
    }
    
    static func find(_ id: Int64) throws -> T? {
        for team in teamData where team.teamId == id {
            return team
        }
        
        return nil
    }
}

// 브리지 계층
struct Team {
    var teamId: Int64?
    var city: String?
    var nickName: String?
    var abbreviation: String?
}

struct Player {
    var playerId: Int64?
    var firstName: String?
    var lastName: String?
    var number: Int?
    var teamId: Int64? {
        didSet {
            if let t = try? TeamBridge.retrieve(teamId!) {
                team = t
            }
        }
    }
    var position: Positions?
    var team: Team?
    
    init(playerId: Int64?, firstName: String?, lastName: String?, number: Int?, teamId: Int64?, position: Positions?) {
        self.playerId = playerId
        self.firstName = firstName
        self.lastName = lastName
        self.number = number
        self.teamId = teamId
        self.position = position
        
        // 초기화 단계에서는 프로퍼티 옵저버가 호출되지 않는다.
        if let id = self.teamId {
            if let t = try? TeamBridge.retrieve(id) {
                team = t
            }
        }
    }
}

struct TeamBridge {
    static func save(_ team: inout Team) throws {
        let teamData = toTeamData(team)
        let id = try TeamDataHelper.insert(teamData)
        team.teamId = id
    }
    
    static func delete(_ team: Team) throws {
        let teamData = toTeamData(team)
        try TeamDataHelper.delete(teamData)
    }
    
    static func retrieve(_ id: Int64) throws -> Team? {
        if let t = try TeamDataHelper.find(id) {
            return toTeam(t)
        }
        return nil
    }
    
    static func toTeamData(_ team: Team) -> TeamData {
        return TeamData(teamId: team.teamId, city: team.city, nickName: team.nickName, abbreviation: team.abbreviation)
    }
    
    static func toTeam(_ teamData: TeamData) -> Team {
        return Team(teamId: teamData.teamId, city: teamData.city, nickName: teamData.nickName, abbreviation: teamData.abbreviation)
    }
}
