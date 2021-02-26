//
//  StructureCOWDeserialization.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-14.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func structureCOWDeserialization(mutable: Bool) -> String {
    let sanityChecks = elements.map { "guard recordDeserialized.val.\($0.name) == record.val.\($0.name) else { fatalError() }" }.joined(separator: "\n    ")

    return """
    func structureCOW\(mutable ? _Var : _Let)Deserialization(\(COUNTER_PARAMETER)) {
        let record = Box(randomRecordStructure())
        let recordSerialized = try! encoder.encode(record.val)
        \(MAKE_ARRAY("data", of: ["recordSerialized"]))

        \(START_MEASURING)
        \(mutable ? _var : _let) recordDeserialized = try! Box(decoder.decode(RecordStructure.self, from: recordSerialized))
        \(END_MEASURING)
        \(INCREMENT_COUNTER)

        \(SANITY_CHECKS_ENABLED ? sanityChecks : "")
        \(mutable ? "recordDeserialized = Box(randomRecordStructure())" : "")
        \(MAKE_ARRAY(of: ["record", "recordDeserialized"]))
    }
    """
}
