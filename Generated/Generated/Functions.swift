//
//  Functions.swift
//  Record
//
//  Created by Justin Xu on 2019-07-12.
//  Copyright © 2019 Justin Xu. All rights reserved.
//

import Foundation

@inline(never) func useRecord(_ record: RecordDictionary) -> DispatchTime {
    let end = DispatchTime.now()
    let array = [record]
    GLOBAL_COUNTER += array.count
    return end
}

@inline(never) func useRecord(_ record: RecordStructure) -> DispatchTime {
    let end = DispatchTime.now()
    let array = [record]
    GLOBAL_COUNTER += array.count
    return end
}

@inline(never) func useRecord(_ record: Box) -> DispatchTime {
    let end = DispatchTime.now()
    let array = [record]
    GLOBAL_COUNTER += array.count
    return end
}

@inline(never) func useRecord(_ record: RecordClass) -> DispatchTime {
    let end = DispatchTime.now()
    let array = [record]
    GLOBAL_COUNTER += array.count
    return end
}
