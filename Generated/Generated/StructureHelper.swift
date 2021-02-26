//
//  StructureHelper.swift
//  Record
//
//  Created by Justin Xu on 2019-07-01.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

final class Ref {
    final var val: RecordStructure
    @inline(__always) init(_ val: RecordStructure) {
        self.val = val
    }
}

struct Box {
    var ref: Ref
    @inline(__always) init(_ val: RecordStructure) {
        self.ref = Ref(val)
    }

    var val: RecordStructure {
        @inline(__always) get { return self.ref.val }
        @inline(__always) set { if isKnownUniquelyReferenced(&ref) { self.ref.val = newValue } else { self.ref = Ref(newValue) } }
    }
}
