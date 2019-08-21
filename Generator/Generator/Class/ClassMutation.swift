//
//  ClassMutation.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func classMutation(with mutableElements: [Element], mutable: Bool) -> String {
    let mutations = mutableElements.map { "record.\($0.name) = \($0.name)" }.joined(separator: "\n    ")
    
    let sanityChecks = mutableElements.map { "guard record.\($0.name) == \($0.name) else { fatalError() }" }.joined(separator: "\n    ")
    
    return """
    func class\(mutable ? _Var : _Let)Mutation(\(COUNTER_PARAMETER)) {
        \(mutable ? _var : _let) record = randomRecordClass()
        \(MAKE_ARRAY("declarations"))
    
        \(GET_RANDOM_ELEMENTS(mutableElements))
    
        \(START_MEASURING)
        \(mutations)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)
    
        \(SANITY_CHECKS_ENABLED ? sanityChecks : "")
        \(mutable ? "record = randomRecordClass()" : "")
        \(MAKE_ARRAY())
    }
    """
}
