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

/// 제네릭 타입 제약
func testGenericComparable<T: Comparable>(a: T, b: T) -> Bool {
    return a == b
}

class MyClass {}
protocol MyProtocol {}

func testFunction<T: MyClass, E: MyProtocol>(a: T, b: E) {
    
}

/// 제네릭 타입
var stringList = List<String>()
var intList = List<Int>()
var customList = List<MyClass>()

// 클래스나 enum도 가능
class GenericClass<T> {
    
}

enum GenericEnum<T> {
    
}

// 제네릭으로 List 만들기
struct List<T> {
    var items = [T]()
    
    mutating func add(item: T) {
        items.append(item)
    }
    
    func getItemAtIndex(index: Int) -> T? {
        if items.count > index {
            return items[index]
        } else {
            return nil
        }
    }
}

var list = List<String>()
list.add(item: "Hello")
list.add(item: "World")
print(list.getItemAtIndex(index: 1))

// 여러 플레이스홀더 타입
class MyObject<T, E> { }

var mo = MyObject<String, Int>()

// 타입 제약
struct MyStruct<T: Comparable> { }

/// 연관 타입
protocol MyAssociatedProtocol {
    associatedtype E
    var items: [E] {get set}
    mutating func add(item: E)
}

struct MyIntType: MyAssociatedProtocol {
    var items: [Int] = []
    mutating func add(item: Int) {
        items.append(item)
    }
}

struct MyGenericType<T>: MyAssociatedProtocol {
    var items: [T] = []
    mutating func add(item: T) {
        items.append(item)
    }
}

/// 제네릭 서브스크립트
extension List {
    subscript(index: Int) -> T? {
        return getItemAtIndex(index: index)
    }
    
    subscript<E: Sequence>(indices: E) -> [T] where E.Iterator.Element == Int {
        var result = [T]()
        for index in indices {
            result.append(items[index])
        }
        return result
    }
}

var myList = List<Int>()
myList.add(item: 1)
myList.add(item: 2)
myList.add(item: 3)
myList.add(item: 4)
myList.add(item: 5)

var values = myList[2...4]
print(values)

/// 커스텀 타입에 Copy-on-write 구현하기 🌟
// class로 내부 큐 정의
fileprivate class BackendQueue<T> {
    private var items = [T]()
    
    public init() { }
    
    // 내부적으로 자신의 복사본을 생성할 때 사용
    private init(_ items: [T]) {
        self.items = items
    }
    
    public func addItem(item: T) {
        items.append(item)
    }
    
    public func printItems() {
        print("\(items)")
    }
    
    public func getItem() -> T? {
        if items.count > 0 {
            return items.remove(at: 0)
        } else {
            return nil
        }
    }
    
    public func count() -> Int {
        return items.count
    }
    
    // 타입 내에 자신의 복사본을 생성하는 로직을 유지하면 변경 사항이 생겼을 때, 이 부분만 변경하면 되기 때문에 효율적이다.
    public func copy() -> BackendQueue<T> {
        return BackendQueue<T>(items)
    }
}

// struct로 메인 큐 정의
struct Queue {
    private var internalQueue = BackendQueue<Int>()
    
    public mutating func addItem(item: Int) {
        checkUniquelyReferencedInternerQueue()
        internalQueue.addItem(item: item)
    }
    
    public mutating func getItem() -> Int? {
        checkUniquelyReferencedInternerQueue()
        return internalQueue.getItem()
    }
    
    public func count() -> Int {
        return internalQueue.count()
    }
    
    mutating private func checkUniquelyReferencedInternerQueue() {
        if !isKnownUniquelyReferenced(&internalQueue) {
            internalQueue = internalQueue.copy()
            print("Making a copy of internalQueue")
        } else {
            print("Not making a copy of internalQueue")
        }
    }
    
    mutating public func uniquelyReferenced() -> Bool {
        return isKnownUniquelyReferenced(&internalQueue)
    }
    
    public func printItems() {
        internalQueue.printItems()
    }
}

var queue = Queue()
queue.addItem(item: 1)

print(queue.uniquelyReferenced())

var queue2 = queue
print(queue.uniquelyReferenced())
print(queue2.uniquelyReferenced())

// queue의 변경이 일어날 때 새로운 복사본이 생성되고 참조 카운트가 1,1 로 변경된다.
queue.addItem(item: 2)
print(queue.uniquelyReferenced())
print(queue2.uniquelyReferenced())

queue.printItems()
queue2.printItems()
