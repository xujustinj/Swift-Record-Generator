//
//  Random.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-06-28.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

protocol Randomizable {
    static func random() -> Self
}

extension Int: Randomizable {
    static func random() -> Int {
        return random(in: min...max)
    }

    static func random(to x: Int) -> Int {
        if x > 0 {
            return random(in: 0...x)
        } else if x < 0 {
            return random(in: x...0)
        } else {
            return 0
        }
    }
}

extension UInt: Randomizable {
    static func random() -> UInt {
        return random(in: UInt.min...UInt.max)
    }
}

extension Double: Randomizable {
    static func random() -> Double {
        return random(in: Double(Int.min)...Double(Int.max))
    }
}

extension Bool: Randomizable { }

fileprivate let VALID_STRING_CHARS: [Character] = Array("QWERYUIOPASDFGHJKLZXCVBNM1234567890qwertyuiopasdfghjklzxcvbnm_?<>,./!@#$%^&*()_+-=[]{}|~`';")
extension String: Randomizable {
    static func random() -> String {
        var str = ""
        for _ in 0...Int.random(to: MAX_STRING_LENGTH) {
            str.append(VALID_STRING_CHARS.randomElement()!)
        }
        return str
    }
}

extension Date: Randomizable {
    static func random() -> Date {
        return Date(timeIntervalSinceNow: Double.random())
    }
}

func fill<T>(_ count: Int, _ generator: () -> T) -> [T] {
    return (0..<count).map { _ in generator() }
}
extension Array where Element: Randomizable {
    static func random() -> [Element] {
        return fill(Int.random(in: 0...MAX_COLLECTION_SIZE)) { Element.random() }
    }
}
extension Array {
    func count(where predicate: (Element) -> Bool) -> Int {
        var counter = 0
        self.forEach {
            if predicate($0) { counter += 1 }
        }
        return counter
    }
}

extension Dictionary where Key == String, Value: Randomizable {
    static func random() -> [Key : Value] {
        let count = Int.random(in: 0...MAX_COLLECTION_SIZE)
        return Dictionary(uniqueKeysWithValues: zip(
            fill(count) { randomName() },
            fill(count) { Value.random() }
        ))
    }
}
