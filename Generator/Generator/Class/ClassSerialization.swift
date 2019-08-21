//
//  ClassSerialization.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-14.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func classSerialization(mutable: Bool) -> String {
    return """
    func class\(mutable ? _Var : _Let)Serialization(\(COUNTER_PARAMETER)) {
        \(mutable ? _var : _let) record = randomRecordClass()
        \(MAKE_ARRAY("declarations"))
    
        \(START_MEASURING)
        let recordSerialized = try! encoder.encode(record)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)
    
        \(mutable ? "record = randomRecordClass()" : "")
        \(MAKE_ARRAY(of: ["recordSerialized"]))
    }
    """
}
