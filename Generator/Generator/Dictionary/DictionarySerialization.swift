//
//  DictionarySerialization.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func dictionarySerialization(mutable: Bool) -> String {
    return """
    func dictionary\(mutable ? _Var : _Let)Serialization(\(COUNTER_PARAMETER)) {
        \(mutable ? _var : _let) record = randomRecordDictionary()
        \(MAKE_ARRAY("declarations"))

        \(START_MEASURING)
        let recordSerialized = try! JSONSerialization.data(withJSONObject: record)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)

        \(mutable ? "record = randomRecordDictionary()" : "")
        \(MAKE_ARRAY(of: ["recordSerialized"]))
    }
    """
}
