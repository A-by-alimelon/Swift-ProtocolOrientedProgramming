//
//  main.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/11.
//

import Foundation
/// 디자인 패턴
/// 생성
// 싱글턴 패턴
class MySingleton {
    static let sharedInstance = MySingleton()
    var number = 0
    private init() {}
}

