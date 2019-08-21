//
//  Tests.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-09.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

// Write the settings to our test project.
func writeSettings(with elements: [Element]) {
    let SETTINGS_PATH = GENERATOR_PATH.appendingPathComponent("Settings.swift")
    
    let output = """
    let ELEMENT_COUNT = \(ELEMENT_COUNT)
    let MUTABLE_ELEMENT_COUNT = \(MUTABLE_ELEMENT_COUNT)
        
    let MAX_STRING_LENGTH = \(MAX_STRING_LENGTH)
    let MIN_NAME_LENGTH = \(MIN_NAME_LENGTH)
    let MAX_NAME_LENGTH = \(MAX_NAME_LENGTH)
    let MAX_COLLECTION_SIZE = \(MAX_COLLECTION_SIZE)
    
    let SANITY_CHECKS_ENABLED = \(SANITY_CHECKS_ENABLED)
    
    let ELEMENTS = \"\"\"
    \(elements.map { "\($0)" }.joined(separator: "\n"))
    \"\"\"
    """
    
    print(output)
        
    try! output.write(to: SETTINGS_PATH, atomically: true, encoding: String.Encoding.utf8)
}

let COUNTER_PARAMETER = "_ counter: inout UInt64"
let START_MEASURING = "let start = DispatchTime.now()"
let END_MEASURING = "let end = DispatchTime.now()"
let INITIALIZE_START = "var start: DispatchTime"
let INITIALIZE_END = "var end: DispatchTime"
let SET_START = "start = DispatchTime.now()"
let USE_RECORD = "let end = useRecord(record)"
let INCREMENT_COUNTER = "counter += end.uptimeNanoseconds - start.uptimeNanoseconds"
let GLOBAL_COUNTER = "GLOBAL_COUNTER"
func MAKE_ARRAY(_ name: String = "array", of names: [String] = ["record"]) -> String {
    return """
    let \(name) = [\(names.joined(separator: ", "))]
        \(GLOBAL_COUNTER) += \(name).count
    """
}
func MAKE_ELEMENT_ARRAY(_ name: String = "elements", with elements: [Element], allOptional: Bool = false) -> String {
    if allOptional {
        let nilCheck = elements.map {
            return "let \($0.name)isNil = \($0.name) == nil"
        }.joined(separator: "\n    ")
        let names = elements.map { "\($0.name)isNil" }
        return """
        \(nilCheck)
            let \(name): [Bool] = [\(names.joined(separator: ", "))]
            \(GLOBAL_COUNTER) += \(name).count
        """
    } else {
        let names = elements.map { "\($0.name)\($0.isOptional ? " == nil" : "")" }
        return """
        let \(name): [Any] = [\(names.joined(separator: ", "))] as [Any]
            \(GLOBAL_COUNTER) += \(name).count
        """
    }
}
func GET_RANDOM_ELEMENTS(_ elements: [Element], makeArray: Bool = true) -> String {
    let getRandom = elements.map { element -> String in
        if element.isOptional {
            switch element.wrapper {
            case .none:
                return "let \(element.name) = Bool.random() ? \(element.type).random() : nil"
            case .array:
                return "let \(element.name) = Bool.random() ? fill(Int.random(in: 0...MAX_COLLECTION_SIZE)) { \(element.type).random() } : nil"
            case .dictionary:
                return "let \(element.name) = Bool.random() ? Dictionary(uniqueKeysWithValues: fill(Int.random(in: 0...MAX_COLLECTION_SIZE)) { (String.randomName(), \(element.type).random()) }) : nil"
            }
        } else {
            switch element.wrapper {
            case .none:
                return "let \(element.name) = \(element.type).random()"
            case .array:
                return "let \(element.name) = fill(Int.random(in: 0...MAX_COLLECTION_SIZE)) { \(element.type).random() }"
            case .dictionary:
                return "let \(element.name) = Dictionary(uniqueKeysWithValues: fill(Int.random(in: 0...MAX_COLLECTION_SIZE)) { (String.randomName(), \(element.type).random()) })"
            }
        }
    }.joined(separator: "\n    ")
    
    if makeArray {
        return """
        \(getRandom)
            \(MAKE_ELEMENT_ARRAY("random", with: elements))
        """
    } else {
        return getRandom
    }
}
let _let = "let"
let _Let = "Let"
let _var = "var"
let _Var = "Var"


/// Creates the three Record implementations using the given list of elements.
func writeDefinitions(with elements: [Element]) {
    let RECORD_PATH = GENERATOR_PATH.appendingPathComponent("Record.swift")
    
    try! """
    import Foundation
    
    \(dictionaryDefinition(with: elements))
        
    \(structureDefinition(with: elements))
        
    \(classDefinition(with: elements))
    """.write(to: RECORD_PATH, atomically: true, encoding: String.Encoding.utf8)
}


/// Measures the time taken to initialize count Records.
func writeInitializations(with elements: [Element]) {
    let INITIALIZATION_PATH = GENERATOR_PATH.appendingPathComponent("Initialization.swift")
    
    try! """
    import Foundation
        
    \(dictionaryInitialization(with: elements, mutable: false))
    \(dictionaryInitialization(with: elements, mutable: true))
        
    \(structureInitialization(with: elements, mutable: false))
    \(structureInitialization(with: elements, mutable: true))
        
    \(structureCOWInitialization(with: elements, mutable: false))
    \(structureCOWInitialization(with: elements, mutable: true))
        
    \(classInitialization(with: elements, mutable: false))
    \(classInitialization(with: elements, mutable: true))
    """.write(to: INITIALIZATION_PATH, atomically: true, encoding: String.Encoding.utf8)
}


/// Initializes count Records.
/// Measures the time taken to read every property of the Record into a different let constant.
func writeRetrievals(with elements: [Element]) {
    let RETRIEVAL_PATH = GENERATOR_PATH.appendingPathComponent("Retrieval.swift")
    
    try! """
    import Foundation
        
    \(dictionaryRetrieval(with: elements, mutable: false))
    \(dictionaryRetrieval(with: elements, mutable: true))
        
    \(structureRetrieval(with: elements, mutable: false))
    \(structureRetrieval(with: elements, mutable: true))
        
    \(structureCOWRetrieval(with: elements, mutable: false))
    \(structureCOWRetrieval(with: elements, mutable: true))
        
    \(classRetrieval(with: elements, mutable: false))
    \(classRetrieval(with: elements, mutable: true))
    """.write(to: RETRIEVAL_PATH, atomically: true, encoding: String.Encoding.utf8)
}


/// Initializes count Records.
/// Measures the time taken to mutate every mutable property of each Record.
func writeMutations(with elements: [Element]) {
    let MUTATION_PATH = GENERATOR_PATH.appendingPathComponent("Mutation.swift")
    
    let mutableElements = elements.filter { $0.isMutable }
    
    try! """
    import Foundation
        
    \(dictionaryCopyMutation(with: mutableElements))
    \(dictionaryMutation(with: mutableElements))
        
    \(structureCopyMutation(with: mutableElements))
    \(structureMutation(with: mutableElements))
        
    \(structureCOWCopyMutation(with: mutableElements))
    \(structureCOWMutation(with: mutableElements))
        
    \(classMutation(with: mutableElements, mutable: false))
    \(classMutation(with: mutableElements, mutable: true))
    """.write(to: MUTATION_PATH, atomically: true, encoding: String.Encoding.utf8)
}


/// Initializes name.count Records.
/// Measures the time taken to pass each Record as the single parameter of a top-level function.
func writePassing() {
    let PASSING_PATH = GENERATOR_PATH.appendingPathComponent("Passing.swift")
 
    try! """
    import Foundation
        
    \(dictionaryPassing(mutable: false))
    \(dictionaryPassing(mutable: true))
        
    \(structurePassing(mutable: false))
    \(structurePassing(mutable: true))
        
    \(structureCOWPassing(mutable: false))
    \(structureCOWPassing(mutable: true))
        
    \(classPassing(mutable: false))
    \(classPassing(mutable: true))
    """.write(to: PASSING_PATH, atomically: true, encoding: String.Encoding.utf8)
}


/// Initializes name.count Records.
/// Measures the time taken to serialize each Record as JSON.
func writeSerializations() {
    let SERIALIZATION_PATH = GENERATOR_PATH.appendingPathComponent("Serialization.swift")
    
    try! """
    import Foundation
    
    fileprivate let encoder = JSONEncoder()
    
    \(dictionarySerialization(mutable: false))
    \(dictionarySerialization(mutable: true))
        
    \(structureSerialization(mutable: false))
    \(structureSerialization(mutable: true))
        
    \(structureCOWSerialization(mutable: false))
    \(structureCOWSerialization(mutable: true))
        
    \(classSerialization(mutable: false))
    \(classSerialization(mutable: true))
    """.write(to: SERIALIZATION_PATH, atomically: true, encoding: String.Encoding.utf8)
}


/// Initializes name.count Records and serializes them as JSON.
/// Measures the time taken to deserialize each Record back from JSON.
func writeDeserializations() {
    let DESERIALIZATION_PATH = GENERATOR_PATH.appendingPathComponent("Deserialization.swift")
    
    try! """
    import Foundation
    
    fileprivate let encoder = JSONEncoder()
    fileprivate let decoder = JSONDecoder()
    
    \(dictionaryDeserialization(mutable: false))
    \(dictionaryDeserialization(mutable: true))
    
    \(structureDeserialization(mutable: false))
    \(structureDeserialization(mutable: true))
    
    \(structureCOWDeserialization(mutable: false))
    \(structureCOWDeserialization(mutable: true))
    
    \(classDeserialization(mutable: false))
    \(classDeserialization(mutable: true))
    """.write(to: DESERIALIZATION_PATH, atomically: true, encoding: String.Encoding.utf8)
}


/// Initializes an array of random Records.
/// Measures the time taken to sort it.
func writeSorting(with elements: [Element]) {
    let SORTING_PATH = GENERATOR_PATH.appendingPathComponent("Sorting.swift")
    
    let element = elements.randomElement() ?? elements[0]
    
    try! """
    import Foundation
    
    \(dictionarySorting(by: element, mutable: false))
    \(dictionarySorting(by: element, mutable: true))
    
    \(structureSorting(by: element, mutable: false))
    \(structureSorting(by: element, mutable: true))
    
    \(structureCOWSorting(by: element, mutable: false))
    \(structureCOWSorting(by: element, mutable: true))
    
    \(classSorting(by: element, mutable: false))
    \(classSorting(by: element, mutable: true))
    """.write(to: SORTING_PATH, atomically: true, encoding: String.Encoding.utf8)
}
