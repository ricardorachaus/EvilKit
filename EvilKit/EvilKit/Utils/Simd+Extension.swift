//
//  Simd+Extension.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 03/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import simd

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

extension Float: Sizeable {}
extension float2: Sizeable {}
extension float3: Sizeable {}
extension float4: Sizeable {}

internal extension matrix_float4x4 {

    mutating func translate(direction: float3) {
        var result = matrix_identity_float4x4

        let x: Float = direction.x
        let y: Float = direction.y
        let z: Float = direction.z

        result.columns = (
            float4(1, 0, 0, 0),
            float4(0, 1, 0, 0),
            float4(0, 0, 1, 0),
            float4(x, y, z, 1)
        )

        self = matrix_multiply(self, result)
    }

    mutating func scale(axis: float3) {
        var result = matrix_identity_float4x4

        let x: Float = axis.x
        let y: Float = axis.y
        let z: Float = axis.z

        result.columns = (
            float4(x, 0, 0, 0),
            float4(0, y, 0, 0),
            float4(0, 0, z, 0),
            float4(0, 0, 0, 1)
        )

        self = matrix_multiply(self, result)
    }


    mutating func rotate(angle: Float, axis: float3) {
        var result = matrix_identity_float4x4

        let x: Float = axis.x
        let y: Float = axis.y
        let z: Float = axis.z

        let c: Float = cos(angle)
        let s: Float = sin(angle)

        let mc: Float = (1 - c)

        let r1c1: Float = x * x * mc + c
        let r2c1: Float = x * y * mc + z * s
        let r3c1: Float = x * z * mc - y * s
        let r4c1: Float = 0.0

        let r1c2: Float = y * x * mc - z * s
        let r2c2: Float = y * y * mc + c
        let r3c2: Float = y * z * mc + x * s
        let r4c2: Float = 0.0

        let r1c3: Float = z * x * mc + y * s
        let r2c3: Float = z * y * mc - x * s
        let r3c3: Float = z * z * mc + c
        let r4c3: Float = 0.0

        let r1c4: Float = 0.0
        let r2c4: Float = 0.0
        let r3c4: Float = 0.0
        let r4c4: Float = 1.0

        result.columns = (
            float4(r1c1, r2c1, r3c1, r4c1),
            float4(r1c2, r2c2, r3c2, r4c2),
            float4(r1c3, r2c3, r3c3, r4c3),
            float4(r1c4, r2c4, r3c4, r4c4)
        )

        self = matrix_multiply(self, result)
    }

}

