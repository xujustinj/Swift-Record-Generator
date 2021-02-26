//
//  ClassPassing.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func classPassing(mutable: Bool) -> String {
    return """
    func class\(mutable ? _Var : _Let)Passing(\(COUNTER_PARAMETER)) {
        \(mutable ? _var : _let) record = randomRecordClass()
        \(MAKE_ARRAY("declarations"))

        \(START_MEASURING)
        \(USE_RECORD)
        \(INCREMENT_COUNTER)

        \(mutable ? "record = randomRecordClass()" : "")
        \(MAKE_ARRAY())
    }
    """
}
