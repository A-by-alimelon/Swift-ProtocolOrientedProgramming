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
    static let sharedInstance = MySingleton() // 정적 상수
    var number = 0
    private init() {} // 추가 인스턴스화 방지
}

var singleA = MySingleton.sharedInstance // 이 때 생성
var singleB = MySingleton.sharedInstance
var singleC = MySingleton.sharedInstance
singleB.number = 2
print(singleA.number)
print(singleB.number)
print(singleC.number)
singleC.number = 3
print(singleA.number)
print(singleB.number)
print(singleC.number)
