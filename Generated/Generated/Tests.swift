//
//  Tests.swift
//  Record
//
//  Created by Justin Xu on 2019-07-02.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func base(_ counter: inout UInt64) {
    let start = DispatchTime.now()
    let end = DispatchTime.now()
    counter += end.uptimeNanoseconds - start.uptimeNanoseconds
}


func printSettings() {
    print("""
            ELEMENT_COUNT: \(ELEMENT_COUNT)
    MUTABLE_ELEMENT_COUNT: \(MUTABLE_ELEMENT_COUNT)
               TEST_COUNT: \(TEST_COUNT)
               ARRAY_SIZE: \(ARRAY_SIZE)
         ARRAY_TEST_COUNT: \(ARRAY_TEST_COUNT)

        MAX_STRING_LENGTH: \(MAX_STRING_LENGTH)
          MIN_NAME_LENGTH: \(MIN_NAME_LENGTH)
          MAX_NAME_LENGTH: \(MAX_NAME_LENGTH)
      MAX_COLLECTION_SIZE: \(MAX_COLLECTION_SIZE)

    SANITY_CHECKS_ENABLED: \(SANITY_CHECKS_ENABLED)

    ELEMENTS:
    \(ELEMENTS)
    """)
}


func measureHashing(times: Int) {
    var time: UInt64 = 0
    for _ in 1...times {
        keyHashing(&time)
    }
    if VERBOSE {
        print("""

        MEAN TIME TO HASH A DICTIONARY KEY
        \(Double(time) / Double(ELEMENT_COUNT * times)) ns
        """)
    } else {
        print("""
        ---
        \(Double(time) / Double(ELEMENT_COUNT * times))
        """)
    }
}


func measureInitialization(times: Int) {
    var dictionaryLetTime: UInt64 = 0
    var dictionaryVarTime: UInt64 = 0
    var structureLetTime: UInt64 = 0
    var structureVarTime: UInt64 = 0
    var structureCOWLetTime: UInt64 = 0
    var structureCOWVarTime: UInt64 = 0
    var classLetTime: UInt64 = 0
    var classVarTime: UInt64 = 0

    var actions = [{ dictionaryLetInitialization(&dictionaryLetTime) },
                   { dictionaryVarInitialization(&dictionaryVarTime) },
                   { structureLetInitialization(&structureLetTime) },
                   { structureVarInitialization(&structureVarTime) },
                   { structureCOWLetInitialization(&structureCOWLetTime) },
                   { structureCOWVarInitialization(&structureCOWVarTime) },
                   { classLetInitialization(&classLetTime) },
                   { classVarInitialization(&classVarTime) }]
    for _ in 1...times {
        actions.shuffle()
        actions.forEach { $0() }
    }

    if VERBOSE {
        print("""

        MEAN TIME TO INITIALIZE, PER ELEMENT
           dictionary (let): \(Double(dictionaryLetTime) / Double(ELEMENT_COUNT * times)) ns
           dictionary (var): \(Double(dictionaryVarTime) / Double(ELEMENT_COUNT * times)) ns
            structure (let): \(Double(structureLetTime) / Double(ELEMENT_COUNT * times)) ns
            structure (var): \(Double(structureVarTime) / Double(ELEMENT_COUNT * times)) ns
        COW structure (let): \(Double(structureCOWLetTime) / Double(ELEMENT_COUNT * times)) ns
        COW structure (var): \(Double(structureCOWVarTime) / Double(ELEMENT_COUNT * times)) ns
                class (let): \(Double(classLetTime) / Double(ELEMENT_COUNT * times)) ns
                class (var): \(Double(classVarTime) / Double(ELEMENT_COUNT * times)) ns
        """)
    } else {
        print("""
        ---
        \(Double(dictionaryLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(dictionaryVarTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureVarTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureCOWLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureCOWVarTime) / Double(ELEMENT_COUNT * times))
        \(Double(classLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(classVarTime) / Double(ELEMENT_COUNT * times))
        """)
    }
}


func measureRetrieval(times: Int) {
    var dictionaryLetTime: UInt64 = 0
    var dictionaryVarTime: UInt64 = 0
    var structureLetTime: UInt64 = 0
    var structureVarTime: UInt64 = 0
    var structureCOWLetTime: UInt64 = 0
    var structureCOWVarTime: UInt64 = 0
    var classLetTime: UInt64 = 0
    var classVarTime: UInt64 = 0

    var actions = [{ dictionaryLetRetrieval(&dictionaryLetTime) },
                   { dictionaryVarRetrieval(&dictionaryVarTime) },
                   { structureLetRetrieval(&structureLetTime) },
                   { structureVarRetrieval(&structureVarTime) },
                   { structureCOWLetRetrieval(&structureCOWLetTime) },
                   { structureCOWVarRetrieval(&structureCOWVarTime) },
                   { classLetRetrieval(&classLetTime) },
                   { classVarRetrieval(&classVarTime) }]
    for _ in 1...times {
        actions.shuffle()
        actions.forEach { $0() }
    }

    if VERBOSE {
        print("""

        MEAN TIME TO RETRIEVE AN ELEMENT
           dictionary (let): \(Double(dictionaryLetTime) / Double(ELEMENT_COUNT * times)) ns
           dictionary (var): \(Double(dictionaryVarTime) / Double(ELEMENT_COUNT * times)) ns
            structure (let): \(Double(structureLetTime) / Double(ELEMENT_COUNT * times)) ns
            structure (var): \(Double(structureVarTime) / Double(ELEMENT_COUNT * times)) ns
        COW structure (let): \(Double(structureCOWLetTime) / Double(ELEMENT_COUNT * times)) ns
        COW structure (var): \(Double(structureCOWVarTime) / Double(ELEMENT_COUNT * times)) ns
                class (let): \(Double(classLetTime) / Double(ELEMENT_COUNT * times)) ns
                class (var): \(Double(classVarTime) / Double(ELEMENT_COUNT * times)) ns
        """)
    } else {
        print("""
        ---
        \(Double(dictionaryLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(dictionaryVarTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureVarTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureCOWLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureCOWVarTime) / Double(ELEMENT_COUNT * times))
        \(Double(classLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(classVarTime) / Double(ELEMENT_COUNT * times))
        """)
    }
}


func measureMutation(times: Int) {
    var dictionaryLetTime: UInt64 = 0
    var dictionaryVarTime: UInt64 = 0
    var structureLetTime: UInt64 = 0
    var structureVarTime: UInt64 = 0
    var structureCOWLetTime: UInt64 = 0
    var structureCOWVarTime: UInt64 = 0
    var classLetTime: UInt64 = 0
    var classVarTime: UInt64 = 0

    var actions = [{ dictionaryLetMutation(&dictionaryLetTime) },
                   { dictionaryVarMutation(&dictionaryVarTime) },
                   { structureLetMutation(&structureLetTime) },
                   { structureVarMutation(&structureVarTime) },
                   { structureCOWLetMutation(&structureCOWLetTime) },
                   { structureCOWVarMutation(&structureCOWVarTime) },
                   { classLetMutation(&classLetTime) },
                   { classVarMutation(&classVarTime) }]
    for _ in 1...times {
        actions.shuffle()
        actions.forEach { $0() }
    }

    if VERBOSE {
        print("""

        MEAN TIME TO MUTATE AN ELEMENT
           dictionary (let): \(Double(dictionaryLetTime) / Double(MUTABLE_ELEMENT_COUNT * times)) ns
           dictionary (var): \(Double(dictionaryVarTime) / Double(MUTABLE_ELEMENT_COUNT * times)) ns
            structure (let): \(Double(structureLetTime) / Double(MUTABLE_ELEMENT_COUNT * times)) ns
            structure (var): \(Double(structureVarTime) / Double(MUTABLE_ELEMENT_COUNT * times)) ns
        COW structure (let): \(Double(structureCOWLetTime) / Double(MUTABLE_ELEMENT_COUNT * times)) ns
        COW structure (var): \(Double(structureCOWVarTime) / Double(MUTABLE_ELEMENT_COUNT * times)) ns
                class (let): \(Double(classLetTime) / Double(MUTABLE_ELEMENT_COUNT * times)) ns
                class (var): \(Double(classVarTime) / Double(MUTABLE_ELEMENT_COUNT * times)) ns
        """)
    } else {
        print("""
        ---
        \(Double(dictionaryLetTime) / Double(MUTABLE_ELEMENT_COUNT * times))
        \(Double(dictionaryVarTime) / Double(MUTABLE_ELEMENT_COUNT * times))
        \(Double(structureLetTime) / Double(MUTABLE_ELEMENT_COUNT * times))
        \(Double(structureVarTime) / Double(MUTABLE_ELEMENT_COUNT * times))
        \(Double(structureCOWLetTime) / Double(MUTABLE_ELEMENT_COUNT * times))
        \(Double(structureCOWVarTime) / Double(MUTABLE_ELEMENT_COUNT * times))
        \(Double(classLetTime) / Double(MUTABLE_ELEMENT_COUNT * times))
        \(Double(classVarTime) / Double(MUTABLE_ELEMENT_COUNT * times))
        """)
    }
}


func measurePassing(times: Int) {
    var dictionaryLetTime: UInt64 = 0
    var dictionaryVarTime: UInt64 = 0
    var structureLetTime: UInt64 = 0
    var structureVarTime: UInt64 = 0
    var structureCOWLetTime: UInt64 = 0
    var structureCOWVarTime: UInt64 = 0
    var classLetTime: UInt64 = 0
    var classVarTime: UInt64 = 0

    var actions = [{ dictionaryLetPassing(&dictionaryLetTime) },
                   { dictionaryVarPassing(&dictionaryVarTime) },
                   { structureLetPassing(&structureLetTime) },
                   { structureVarPassing(&structureVarTime) },
                   { structureCOWLetPassing(&structureCOWLetTime) },
                   { structureCOWVarPassing(&structureCOWVarTime) },
                   { classLetPassing(&classLetTime) },
                   { classVarPassing(&classVarTime) }]
    for _ in 1...times {
        actions.shuffle()
        actions.forEach { $0() }
    }

    if VERBOSE {
        print("""

        MEAN TIME TO PASS AS FUNCTION ARGUMENT
           dictionary (let): \(Double(dictionaryLetTime) / Double(times)) ns
           dictionary (var): \(Double(dictionaryVarTime) / Double(times)) ns
            structure (let): \(Double(structureLetTime) / Double(times)) ns
            structure (var): \(Double(structureVarTime) / Double(times)) ns
        COW structure (let): \(Double(structureCOWLetTime) / Double(times)) ns
        COW structure (var): \(Double(structureCOWVarTime) / Double(times)) ns
                class (let): \(Double(classLetTime) / Double(times)) ns
                class (var): \(Double(classVarTime) / Double(times)) ns
        """)
    } else {
        print("""
        ---
        \(Double(dictionaryLetTime) / Double(times))
        \(Double(dictionaryVarTime) / Double(times))
        \(Double(structureLetTime) / Double(times))
        \(Double(structureVarTime) / Double(times))
        \(Double(structureCOWLetTime) / Double(times))
        \(Double(structureCOWVarTime) / Double(times))
        \(Double(classLetTime) / Double(times))
        \(Double(classVarTime) / Double(times))
        """)
    }
}


func measureSerialization(times: Int) {
    var dictionaryLetTime: UInt64 = 0
    var dictionaryVarTime: UInt64 = 0
    var structureLetTime: UInt64 = 0
    var structureVarTime: UInt64 = 0
    var structureCOWLetTime: UInt64 = 0
    var structureCOWVarTime: UInt64 = 0
    var classLetTime: UInt64 = 0
    var classVarTime: UInt64 = 0

    var actions = [{ dictionaryLetSerialization(&dictionaryLetTime) },
                   { dictionaryVarSerialization(&dictionaryVarTime) },
                   { structureLetSerialization(&structureLetTime) },
                   { structureVarSerialization(&structureVarTime) },
                   { structureCOWLetSerialization(&structureCOWLetTime) },
                   { structureCOWVarSerialization(&structureCOWVarTime) },
                   { classLetSerialization(&classLetTime) },
                   { classVarSerialization(&classVarTime) }]
    for _ in 1...times {
        actions.shuffle()
        actions.forEach { $0() }
    }

    if VERBOSE {
        print("""

        MEAN TIME TO SERIALIZE TO JSON, PER ELEMENT
           dictionary (let): \(Double(dictionaryLetTime) / Double(ELEMENT_COUNT * times)) ns
           dictionary (var): \(Double(dictionaryVarTime) / Double(ELEMENT_COUNT * times)) ns
            structure (let): \(Double(structureLetTime) / Double(ELEMENT_COUNT * times)) ns
            structure (var): \(Double(structureVarTime) / Double(ELEMENT_COUNT * times)) ns
        COW structure (let): \(Double(structureCOWLetTime) / Double(ELEMENT_COUNT * times)) ns
        COW structure (var): \(Double(structureCOWVarTime) / Double(ELEMENT_COUNT * times)) ns
                class (let): \(Double(classLetTime) / Double(ELEMENT_COUNT * times)) ns
                class (var): \(Double(classVarTime) / Double(ELEMENT_COUNT * times)) ns
        """)
    } else {
        print("""
        ---
        \(Double(dictionaryLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(dictionaryVarTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureVarTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureCOWLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureCOWVarTime) / Double(ELEMENT_COUNT * times))
        \(Double(classLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(classVarTime) / Double(ELEMENT_COUNT * times))
        """)
    }
}


func measureDeserialization(times: Int) {
    var dictionaryLetTime: UInt64 = 0
    var dictionaryVarTime: UInt64 = 0
    var structureLetTime: UInt64 = 0
    var structureVarTime: UInt64 = 0
    var structureCOWLetTime: UInt64 = 0
    var structureCOWVarTime: UInt64 = 0
    var classLetTime: UInt64 = 0
    var classVarTime: UInt64 = 0

    var actions = [{ dictionaryLetDeserialization(&dictionaryLetTime) },
                   { dictionaryVarDeserialization(&dictionaryVarTime) },
                   { structureLetDeserialization(&structureLetTime) },
                   { structureVarDeserialization(&structureVarTime) },
                   { structureCOWLetDeserialization(&structureCOWLetTime) },
                   { structureCOWVarDeserialization(&structureCOWVarTime) },
                   { classLetDeserialization(&classLetTime) },
                   { classVarDeserialization(&classVarTime) }]
    for _ in 1...times {
        actions.shuffle()
        actions.forEach { $0() }
    }

    if VERBOSE {
        print("""

        MEAN TIME TO DESERIALIZE FROM JSON, PER ELEMENT
           dictionary (let): \(Double(dictionaryLetTime) / Double(ELEMENT_COUNT * times)) ns
           dictionary (var): \(Double(dictionaryVarTime) / Double(ELEMENT_COUNT * times)) ns
            structure (let): \(Double(structureLetTime) / Double(ELEMENT_COUNT * times)) ns
            structure (var): \(Double(structureVarTime) / Double(ELEMENT_COUNT * times)) ns
        COW structure (let): \(Double(structureCOWLetTime) / Double(ELEMENT_COUNT * times)) ns
        COW structure (var): \(Double(structureCOWVarTime) / Double(ELEMENT_COUNT * times)) ns
                class (let): \(Double(classLetTime) / Double(ELEMENT_COUNT * times)) ns
                class (var): \(Double(classVarTime) / Double(ELEMENT_COUNT * times)) ns
        """)
    } else {
        print("""
        ---
        \(Double(dictionaryLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(dictionaryVarTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureVarTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureCOWLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(structureCOWVarTime) / Double(ELEMENT_COUNT * times))
        \(Double(classLetTime) / Double(ELEMENT_COUNT * times))
        \(Double(classVarTime) / Double(ELEMENT_COUNT * times))
        """)
    }
}


func measureSorting(times: Int) {
    var dictionaryLetTime: UInt64 = 0
    var dictionaryVarTime: UInt64 = 0
    var structureLetTime: UInt64 = 0
    var structureVarTime: UInt64 = 0
    var structureCOWLetTime: UInt64 = 0
    var structureCOWVarTime: UInt64 = 0
    var classLetTime: UInt64 = 0
    var classVarTime: UInt64 = 0

    var actions = [{ dictionaryLetSorting(&dictionaryLetTime) },
                   { dictionaryVarSorting(&dictionaryVarTime) },
                   { structureLetSorting(&structureLetTime) },
                   { structureVarSorting(&structureVarTime) },
                   { structureCOWLetSorting(&structureCOWLetTime) },
                   { structureCOWVarSorting(&structureCOWVarTime) },
                   { classLetSorting(&classLetTime) },
                   { classVarSorting(&classVarTime) }]
    for _ in 1...times {
        actions.shuffle()
        actions.forEach { $0() }
    }

    if VERBOSE {
        print("""

        MEAN TIME TO SORT ARRAY OF \(ARRAY_SIZE) RECORDS
           dictionary (let): \(Double(dictionaryLetTime) / Double(times)) ns
           dictionary (var): \(Double(dictionaryVarTime) / Double(times)) ns
            structure (let): \(Double(structureLetTime) / Double(times)) ns
            structure (var): \(Double(structureVarTime) / Double(times)) ns
        COW structure (let): \(Double(structureCOWLetTime) / Double(times)) ns
        COW structure (var): \(Double(structureCOWVarTime) / Double(times)) ns
                class (let): \(Double(classLetTime) / Double(times)) ns
                class (var): \(Double(classVarTime) / Double(times)) ns
        """)
    } else {
        print("""
        ---
        \(Double(dictionaryLetTime) / Double(times))
        \(Double(dictionaryVarTime) / Double(times))
        \(Double(structureLetTime) / Double(times))
        \(Double(structureVarTime) / Double(times))
        \(Double(structureCOWLetTime) / Double(times))
        \(Double(structureCOWVarTime) / Double(times))
        \(Double(classLetTime) / Double(times))
        \(Double(classVarTime) / Double(times))
        """)
    }
}
