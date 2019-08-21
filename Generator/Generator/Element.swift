//
//  Element.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-06-28.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

let VALID_NAME_FIRST_CHARS: [Character] = Array("qwertyuiopasdfghjklzxcvbnm_")
let VALID_NAME_CHARS: [Character] = Array("1234567890qwertyuiopasdfghjklzxcvbnm_")

enum ElementType: String, CustomStringConvertible {
    case int = "Int"
    case uint = "UInt"
    case double = "Double"
    case bool = "Bool"
    case string = "String"
    case date = "Date"
    
    var description: String {
        return self.rawValue
    }
}

enum ElementWrapper: String, CustomStringConvertible {
    case none = ""
    case array = "Array"
    case dictionary = "Dictionary"
    
    func wrap(_ type: ElementType) -> String {
        switch self {
        case .none:
            return "\(type)"
        case .array:
            return "[\(type)]"
        case .dictionary:
            return "[String : \(type)]"
        }
    }
    
    var description: String {
        switch self {
        case .none: return "none"
        case .array: return "array"
        case .dictionary: return "dictionary"
        }
    }
}

struct Element: CustomStringConvertible {
    let name: String
    let type: ElementType
    let wrapper: ElementWrapper
    let isOptional: Bool
    let isMutable: Bool
    
    func randomValue() -> String {
        func randomString(length: Int) -> String {
            return String((0..<length).map { _ in VALID_NAME_CHARS.randomElement()! })
        }
        
        func wrap(generator: () -> String) -> String {
            switch wrapper {
            case .none:
                return generator()
            case .array:
                return "[\((0...Int.random(to: MAX_COLLECTION_SIZE)).map { _ in generator() }.joined(separator: ", "))]"
            case .dictionary:
                return "[\((0...Int.random(to: MAX_COLLECTION_SIZE)).map { _ in "\"\(randomName())\" : \(generator())" }.joined(separator: ", "))]"
            }
        }
        
        if isOptional && Bool.random() {
            return "nil"
        }
        
        switch type {
        case .int:
            return wrap { String(describing: Int.random()) }
        case .uint:
            return wrap { String(describing: UInt.random()) }
        case .double:
            return wrap { String(describing: Double.random()) }
        case .bool:
            return wrap { String(describing: Bool.random()) }
        case .string:
            return wrap { "\"\(String.random())\"" }
        case .date:
            return wrap { "Date(timeIntervalSinceReferenceDate: \(Double.random()))" }
        }
    }
    
    var key: String {
        return "RecordDictionaryKeys.\(name.uppercased())"
    }
    
    var shortKey: String {
        return ".\(name.uppercased())"
    }
    
    var description: String {
        return "\(isMutable ? _var : _let) \(name): \(wrapper.wrap(type))\(isOptional ? "?" : "")"
    }
}

func randomName() -> String {
    var str = String(VALID_NAME_FIRST_CHARS.randomElement()!)
    for _ in 1...Int.random(in: MIN_NAME_LENGTH..<MAX_NAME_LENGTH) {
        str.append(VALID_NAME_CHARS.randomElement()!)
    }
    return str
}

func randomType() -> ElementType {
    return ELEMENT_TYPES.randomElement()!
}

func randomWrapper() -> ElementWrapper {
    return ELEMENT_WRAPPERS.randomElement()!
}

func randomOptional() -> Bool {
    return ELEMENT_OPTIONALS.randomElement()!
}

func randomMutability() -> Bool {
    return ELEMENT_MUTABILITIES.randomElement()!
}

func randomElement() -> Element {
    return Element(name: randomName(), type: randomType(), wrapper: randomWrapper(), isOptional: randomOptional(), isMutable: randomMutability())
}

extension Element {
    var getter: String {
        return "get\(self.wrapper.rawValue)\(self.type.rawValue)\(self.isOptional ? "" : "ByForce")"
    }
    var setter: String {
        return "set\(self.wrapper.rawValue)\(self.type.rawValue)\(self.isOptional ? "" : "ByForce")"
    }
}
