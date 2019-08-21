//
//  Random.swift
//  Record
//
//  Created by Justin Xu on 2019-06-28.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

protocol Randomizable {
    @inline(__always) static func random() -> Self
}

extension Int: Randomizable {
    @inline(__always) static func random() -> Int {
        return random(in: min...max)
    }
    
    @inline(__always) static func random(to x: Int) -> Int {
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
    @inline(__always) static func random() -> UInt {
        return random(in: UInt.min...UInt.max)
    }
}

extension Double: Randomizable {
    @inline(__always) static func random() -> Double {
        return random(in: Double(Int.min)...Double(Int.max))
    }
}

extension Bool: Randomizable { }

let VALID_STRING_CHARS: [Character] = Array("QWERYUIOPASDFGHJKLZXCVBNM1234567890qwertyuiopasdfghjklzxcvbnm_?<>,./!@#$%^&*()_+-=[]{}|~`';")
let VALID_NAME_FIRST_CHARS: [Character] = Array("qwertyuiopasdfghjklzxcvbnm_")
let VALID_NAME_CHARS: [Character] = Array("1234567890qwertyuiopasdfghjklzxcvbnm_")
extension String: Randomizable {
    @inline(__always) static func random() -> String {
        var str = ""
        for _ in 0...Int.random(to: MAX_STRING_LENGTH) {
            str.append(VALID_STRING_CHARS.randomElement()!)
        }
        return str
    }
    
    @inline(__always) static func randomName() -> String {
        var str = String(VALID_NAME_FIRST_CHARS.randomElement()!)
        for _ in 1...Int.random(in: MIN_NAME_LENGTH..<MAX_NAME_LENGTH) {
            str.append(VALID_NAME_CHARS.randomElement()!)
        }
        return str
    }
}

extension Date: Randomizable {
    @inline(__always) static func random() -> Date {
        return Date(timeIntervalSinceReferenceDate: Double(Int32.random(in: Int32.min...Int32.max)))
    }
}

@inline(__always) func fill<T>(_ count: Int, _ generator: () -> T) -> [T] {
    return (0..<count).map { _ in generator() }
}
extension Array where Element: Randomizable {
    @inline(__always) static func random() -> [Element] {
        return fill(Int.random(in: 0...MAX_COLLECTION_SIZE)) { Element.random() }
    }
}

extension Dictionary where Key == String, Value: Randomizable {
    @inline(__always) static func random() -> [Key : Value] {
        let count = Int.random(in: 0...MAX_COLLECTION_SIZE)
        return Dictionary(uniqueKeysWithValues: zip(
            fill(count) { String.randomName() },
            fill(count) { Value.random() }
        ))
    }
}
