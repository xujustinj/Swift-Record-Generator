//
//  StructureDefinition.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func structureDefinition(with elements: [Element]) -> String {
    let declarations = elements.map {
        "\($0.isMutable ? _var : _let) \($0.name): \($0.wrapper.wrap($0.type))\($0.isOptional ? "?" : "")"
    }.joined(separator: "\n    ")

    let randomParameters = elements.map { element -> String in
        return "\(element.name): \(element.name)"
    }.joined(separator: ", ")

    return """
    struct RecordStructure: Codable {
        \(declarations)
    }

    @inline(__always) func randomRecordStructure() -> RecordStructure {
        \(GET_RANDOM_ELEMENTS(elements, makeArray: false))

        return RecordStructure(\(randomParameters))
    }
    """
}
