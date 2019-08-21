//
//  StructureSerialization.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-14.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func structureSerialization(mutable: Bool) -> String {
    return """
    func structure\(mutable ? _Var : _Let)Serialization(\(COUNTER_PARAMETER)) {
        \(mutable ? _var : _let) record = randomRecordStructure()
        \(MAKE_ARRAY("declarations"))
    
        \(START_MEASURING)
        let recordSerialized = try! encoder.encode(record)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)
    
        \(mutable ? "record = randomRecordStructure()" : "")
        \(MAKE_ARRAY(of: ["recordSerialized"]))
    }
    """
}
