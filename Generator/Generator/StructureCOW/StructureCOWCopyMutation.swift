//
//  StructureCOWCopyMutation.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-14.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func structureCOWCopyMutation(with mutableElements: [Element]) -> String {
    let mutations = mutableElements.map { "recordCopy.val.\($0.name) = \($0.name)" }.joined(separator: "\n    ")

    let sanityChecks = mutableElements.map { "guard recordCopy.val.\($0.name) == \($0.name) else { fatalError() }" }.joined(separator: "\n    ")

    return """
    func structureCOWLetMutation(\(COUNTER_PARAMETER)) {
        let record = Box(randomRecordStructure())
        \(MAKE_ARRAY("declarations"))

        \(GET_RANDOM_ELEMENTS(mutableElements))

        \(START_MEASURING)
        var recordCopy = record
        \(mutations)
        \(END_MEASURING)
        \(INCREMENT_COUNTER)

        \(SANITY_CHECKS_ENABLED ? sanityChecks : "")
        \(MAKE_ARRAY(of: ["recordCopy"]))
    }
    """
}
