//
//  StructurePassing.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func structurePassing(mutable: Bool) -> String {
    return """
    func structure\(mutable ? _Var : _Let)Passing(\(COUNTER_PARAMETER)) {
        \(mutable ? _var : _let) record = randomRecordStructure()
        \(MAKE_ARRAY("declarations"))
    
        \(START_MEASURING)
        \(USE_RECORD)
        \(INCREMENT_COUNTER)
    
        \(mutable ? "record = randomRecordStructure()" : "")
        \(MAKE_ARRAY())
    }
    """
}
