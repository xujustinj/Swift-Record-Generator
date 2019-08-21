//
//  ClassDeserialization.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-14.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func classDeserialization(mutable: Bool) -> String {
    let sanityChecks = elements.map { "guard recordDeserialized.\($0.name) == record.\($0.name) else { fatalError() }" }.joined(separator: "\n    ")
    
    return """
    func class\(mutable ? _Var : _Let)Deserialization(\(COUNTER_PARAMETER)) {
        let record = randomRecordClass()
        let recordSerialized = try! encoder.encode(record)
        \(MAKE_ARRAY("data", of: ["recordSerialized"]))
    
        \(START_MEASURING)
        \(mutable ? _var : _let) recordDeserialized = try! decoder.decode(RecordClass.self, from: recordSerialized)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)
    
        \(SANITY_CHECKS_ENABLED ? sanityChecks : "")
        \(mutable ? "recordDeserialized = randomRecordClass()" : "")
        \(MAKE_ARRAY(of: ["record", "recordDeserialized"]))
    }
    """
}
