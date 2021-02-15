//
//  main.swift
//  ProtocolOrientedProgramming
//
//  Created by A on 2021/02/11.
//

import Foundation

/// 제네릭 함수
func swapGenerics<T>(a: inout T, b: inout T) {
    let tmp = a
    a = b
    b = tmp
}

var a = 5
var b = 10
swapGenerics(a: &a, b: &b)
print("a: \(a) b: \(b)")

var c = "My String 1"
var d = "My String 2"
swapGenerics(a: &c, b: &d)
print("c: \(c) d: \(d)")

// 여러 개의 제네릭 타입
func testGeneric<T, E>(a: T, b: E) {
    print("\(a) \(b)")
}
