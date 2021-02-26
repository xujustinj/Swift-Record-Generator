//
//  DictionaryCopyMutation.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func dictionaryCopyMutation(with mutableElements: [Element]) -> String {
    let mutations = mutableElements.map { "recordCopy.\($0.setter)(key: \($0.key), \($0.name))" }.joined(separator: "\n    ")

    let sanityChecks = mutableElements.map { "guard recordCopy.\($0.getter)(key: \($0.key)) == \($0.name) else { fatalError() }" }.joined(separator: "\n    ")

    return """
    func dictionaryLetMutation(\(COUNTER_PARAMETER)) {
        let record = randomRecordDictionary()
        \(MAKE_ARRAY("declarations"))

        \(GET_RANDOM_ELEMENTS(mutableElements))

        \(START_MEASURING)
        var recordCopy = record
        \(mutations)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)

        \(SANITY_CHECKS_ENABLED ? sanityChecks : "")
        \(MAKE_ARRAY(of: ["recordCopy"]))
    }
    """
}
