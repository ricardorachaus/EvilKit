//
//  Math+Extension.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import Foundation

extension Float: Sizeable {}

internal extension Float {
    var asDouble: Double {
        return Double(self)
    }
}

internal extension CGFloat {
    var asFloat: Float {
        return Float(self)
    }
}

internal extension Double {
    var asCGFloat: CGFloat {
        return CGFloat(self)
    }
}
