//
//  DictionaryDefinition.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func dictionaryDefinition(with elements: [Element]) -> String {
    let constantNames = elements.map {
        "static let \($0.name.uppercased()) = \"\($0.name)\""
    }.joined(separator: "\n    ")
    
    let initializerParameters = elements.map {
        "\($0.name): \($0.wrapper.wrap($0.type))\($0.isOptional ? "?" : "")"
    }.joined(separator: ", ")
    
    let initializeNonOptionals = elements.compactMap { element -> String? in
        guard !element.isOptional else { return nil }
        if element.type == .date {
            switch element.wrapper {
            case .none:
                return "\(element.key) : dateFormatter.string(from: \(element.name))"
            case .array:
                return "\(element.key) : \(element.name).map { dateFormatter.string(from: $0) }"
            case .dictionary:
                return "\(element.key) : \(element.name).mapValues { dateFormatter.string(from: $0) }"
            }
        } else {
            return "\(element.key) : \(element.name)"
        }
    }.joined(separator: ", ")
    
    let initializeOptionals = elements.compactMap { element -> String? in
        guard element.isOptional else { return nil }
        return "record.\(element.setter)(key: \(element.key), \(element.name))"
    }.joined(separator: "\n    ")
    
    let randomParameters = elements.map { element -> String in
        return "\(element.name): \(element.name)"
    }.joined(separator: ", ")
    
    let hashKeys = elements.map { element -> String in
        return "let \(element.name) = \(element.key).hashValue"
    }.joined(separator: "\n    ")
    
    let hashArray = elements.map { element -> String in
        return element.name
    }.joined(separator: ", ")
        
    return """
    typealias RecordDictionary = [String : AnyObject]
    
    enum RecordDictionaryKeys {
        \(constantNames)
    }
    
    @inline(__always) func initRecordDictionary(\(initializerParameters)) -> RecordDictionary {
        var record = [\(initializeNonOptionals)] as RecordDictionary
        \(initializeOptionals)
        return record
    }
    
    @inline(__always) func randomRecordDictionary() -> RecordDictionary {
        \(GET_RANDOM_ELEMENTS(elements, makeArray: false))
    
        return initRecordDictionary(\(randomParameters))
    }
    
    func keyHashing(\(COUNTER_PARAMETER)) {
        \(START_MEASURING)
        \(hashKeys)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)
    
        let array = [\(hashArray)]
        \(GLOBAL_COUNTER) += array.count
    }
    """
}
