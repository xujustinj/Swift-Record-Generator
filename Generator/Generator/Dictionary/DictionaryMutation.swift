//
//  DictionaryMutation.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func dictionaryMutation(with mutableElements: [Element]) -> String {
    let mutations = mutableElements.map { "record.\($0.setter)(key: \($0.key), \($0.name))" }.joined(separator: "\n    ")
    
    let sanityChecks = mutableElements.map { "guard record.\($0.getter)(key: \($0.key)) == \($0.name) else { fatalError() }" }.joined(separator: "\n    ")
    
    return """
    func dictionaryVarMutation(\(COUNTER_PARAMETER)) {
        var record = randomRecordDictionary()
        \(MAKE_ARRAY("declarations"))
    
        \(GET_RANDOM_ELEMENTS(mutableElements))
    
        \(START_MEASURING)
        \(mutations)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)
    
        \(SANITY_CHECKS_ENABLED ? sanityChecks : "")
        \(MAKE_ARRAY())
    }
    """
}
