//
//  main.swift
//  Record
//
//  Created by Justin Xu on 2019-06-30.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

// CONFIGURABLE VALUES
let VERBOSE = true
let TEST_COUNT = 256
let ARRAY_SIZE = 256
let ARRAY_TEST_COUNT = 16

// The global counter is part of an additional sanity check system.
// It gets incremented in every test to guarantee that there are side effects.
// Printed at the end, it can be used to re-verify that all tests ran successfully.
var GLOBAL_COUNTER = 0

if VERBOSE { printSettings() }
measureHashing(times: TEST_COUNT)
measureInitialization(times: TEST_COUNT)
measureRetrieval(times: TEST_COUNT)
measureMutation(times: TEST_COUNT)
measurePassing(times: TEST_COUNT)
measureSerialization(times: TEST_COUNT)
measureDeserialization(times: TEST_COUNT)
measureSorting(times: ARRAY_TEST_COUNT)
if VERBOSE {
    print()
    print("GLOBAL COUNTER: \(GLOBAL_COUNTER)")
}
