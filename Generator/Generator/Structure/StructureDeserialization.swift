//
//  StructureDeserialization.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-14.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func structureDeserialization(mutable: Bool) -> String {
    let sanityChecks = elements.map { "guard recordDeserialized.\($0.name) == record.\($0.name) else { fatalError() }" }.joined(separator: "\n    ")
    
    return """
    func structure\(mutable ? _Var : _Let)Deserialization(\(COUNTER_PARAMETER)) {
        let record = randomRecordStructure()
        let recordSerialized = try! encoder.encode(record)
        \(MAKE_ARRAY("data", of: ["recordSerialized"]))
    
        \(START_MEASURING)
        \(mutable ? _var : _let) recordDeserialized = try! decoder.decode(RecordStructure.self, from: recordSerialized)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)
    
        \(SANITY_CHECKS_ENABLED ? sanityChecks : "")
        \(mutable ? "recordDeserialized = randomRecordStructure()" : "")
        \(MAKE_ARRAY(of: ["record", "recordDeserialized"]))
    }
    """
}
