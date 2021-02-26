//
//  ClassDefinition.swift
//  Swift Record Generator
//
//  Created by Justin Xu on 2019-07-13.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

func classDefinition(with elements: [Element]) -> String {
    let declarations = elements.map {
        "final \($0.isMutable ? _var : _let) \($0.name): \($0.wrapper.wrap($0.type))\($0.isOptional ? "?" : "")"
    }.joined(separator: "\n    ")

    let initializerParameters = elements.map {
        "\($0.name): \($0.wrapper.wrap($0.type))\($0.isOptional ? "?" : "")"
    }.joined(separator: ", ")

    let initializations = elements.map {
        "self.\($0.name) = \($0.name)"
    }.joined(separator: "\n        ")

    let randomParameters = elements.map { element -> String in
        return "\(element.name): \(element.name)"
    }.joined(separator: ", ")

    return """
    final class RecordClass: Codable {
        \(declarations)

        @inline(__always) init(\(initializerParameters)) {
            \(initializations)
        }
    }

    @inline(__always) func randomRecordClass() -> RecordClass {
        \(GET_RANDOM_ELEMENTS(elements, makeArray: false))

        return RecordClass(\(randomParameters))
    }
    """
}
