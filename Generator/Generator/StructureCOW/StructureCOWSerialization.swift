//
//  StructureCOWSerialization.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-14.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func structureCOWSerialization(mutable: Bool) -> String {
    return """
    func structureCOW\(mutable ? _Var : _Let)Serialization(\(COUNTER_PARAMETER)) {
        \(mutable ? _var : _let) record = Box(randomRecordStructure())
        \(MAKE_ARRAY("declarations"))

        \(START_MEASURING)
        let recordSerialized = try! encoder.encode(record.val)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)

        \(mutable ? "record = Box(randomRecordStructure())" : "")
        \(MAKE_ARRAY(of: ["recordSerialized"]))
    }
    """
}
