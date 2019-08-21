//
//  DictionaryRetrieval.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func dictionaryRetrieval(with elements: [Element], mutable: Bool) -> String {
    let retrievals = elements.map { "let \($0.name) = record.\($0.getter)(key: \($0.key))" }.joined(separator: "\n    ")
    
    return """
    func dictionary\(mutable ? _Var : _Let)Retrieval(\(COUNTER_PARAMETER)) {
        \(mutable ? _var : _let) record = randomRecordDictionary()
        \(MAKE_ARRAY())
    
        \(START_MEASURING)
        \(retrievals)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)
    
        \(mutable ? "record = randomRecordDictionary()" : "")
        \(MAKE_ELEMENT_ARRAY(with: elements))
    }
    """
}
