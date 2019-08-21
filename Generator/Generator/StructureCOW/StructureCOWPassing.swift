//
//  StructureCOWPassing.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func structureCOWPassing(mutable: Bool) -> String {
    return """
    func structureCOW\(mutable ? _Var : _Let)Passing(\(COUNTER_PARAMETER)) {
        \(mutable ? _var : _let) record = Box(randomRecordStructure())
        \(MAKE_ARRAY("declarations"))
        
        \(START_MEASURING)
        \(USE_RECORD)
        \(INCREMENT_COUNTER)
    
        \(mutable ? "record = Box(randomRecordStructure())" : "")
        \(MAKE_ARRAY())
    }
    """
}
