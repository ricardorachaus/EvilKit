//
//  Sizeable.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import Foundation

internal protocol Sizeable {}

internal extension Sizeable {
    static var size: Int {
        return MemoryLayout<Self>.size
    }

    static var stride: Int {
        return MemoryLayout<Self>.stride
    }

    static func size(_ count: Int) -> Int {
        return size * count
    }

    static func stride(_ count: Int) -> Int {
        return stride * count
    }
}
