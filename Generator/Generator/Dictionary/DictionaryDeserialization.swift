//
//  DictionaryDeserialization.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-14.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func dictionaryDeserialization(mutable: Bool) -> String {
    let sanityChecks = elements.map { "guard recordDeserialized.\($0.getter)(key: \($0.key)) == record.\($0.getter)(key: \($0.key)) else { fatalError() }" }.joined(separator: "\n    ")
    
    return """
    func dictionary\(mutable ? _Var : _Let)Deserialization(\(COUNTER_PARAMETER)) {
        let record = randomRecordDictionary()
        let recordSerialized = try! JSONSerialization.data(withJSONObject: record)
        \(MAKE_ARRAY("data", of: ["recordSerialized"]))
    
        \(START_MEASURING)
        \(mutable ? _var : _let) recordDeserialized = try! JSONSerialization.jsonObject(with: recordSerialized) as! RecordDictionary
        \(END_MEASURING)
        \(INCREMENT_COUNTER)
    
        \(SANITY_CHECKS_ENABLED ? sanityChecks : "")
        \(mutable ? "recordDeserialized = randomRecordDictionary()" : "")
        \(MAKE_ARRAY(of: ["record", "recordDeserialized"]))
    }
    """
}
