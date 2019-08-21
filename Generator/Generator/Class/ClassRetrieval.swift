//
//  ClassRetrieval.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func classRetrieval(with elements: [Element], mutable: Bool) -> String {
    let retrievals = elements.map { "let \($0.name) = record.\($0.name)" }.joined(separator: "\n    ")
    
    return """
    func class\(mutable ? _Var : _Let)Retrieval(\(COUNTER_PARAMETER)) {
        \(mutable ? _var : _let) record = randomRecordClass()
        \(MAKE_ARRAY())
    
        \(START_MEASURING)
        \(retrievals)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)
    
        \(mutable ? "record = randomRecordClass()" : "")
        \(MAKE_ELEMENT_ARRAY(with: elements))
    }
    """
}
