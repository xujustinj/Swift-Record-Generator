//
//  main.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-06-28.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

// CONFIGURABLE VALUES
let GENERATOR_PATH = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("SwiftRecordGenerator").appendingPathComponent("Generated").appendingPathComponent("Generated").appendingPathComponent("Generated")
let ELEMENT_COUNT = 16
let MAX_STRING_LENGTH: Int = 64
let MIN_NAME_LENGTH: Int = 4
let MAX_NAME_LENGTH: Int = 24
let MAX_COLLECTION_SIZE: Int = 16
let ELEMENT_TYPES: [ElementType] = [.int, .int, .int, .uint, .double, .bool, .string, .string, .string, .date]
let ELEMENT_WRAPPERS: [ElementWrapper] = [.none, .none, .none, .array, .dictionary]
let ELEMENT_OPTIONALS: [Bool] = [false, false, false, false, true]
let ELEMENT_MUTABILITIES: [Bool] = [false, false, false, false, true]
let SANITY_CHECKS_ENABLED = true
let elements: [Element] = fill(ELEMENT_COUNT) { randomElement() }

let MUTABLE_ELEMENT_COUNT = elements.count { $0.isMutable }

print()
writeSettings(with: elements)
writeDefinitions(with: elements)
writeInitializations(with: elements)
writeRetrievals(with: elements)
writeMutations(with: elements)
writePassing()
writeSerializations()
writeDeserializations()
writeSorting(with: elements)
