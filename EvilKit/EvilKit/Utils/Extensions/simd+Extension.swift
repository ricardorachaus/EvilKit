//
//  simd+Extension.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import simd

extension SIMD2: Sizeable {}
extension SIMD3: Sizeable {}
extension SIMD4: Sizeable {}

internal extension matrix_float4x4 {

    mutating func translate(direction: SIMD3<Float>) {
        var result = matrix_identity_float4x4

        let x: Float = direction.x
        let y: Float = direction.y
        let z: Float = direction.z

        result.columns = (
            SIMD4<Float>(1, 0, 0, 0),
            SIMD4<Float>(0, 1, 0, 0),
            SIMD4<Float>(0, 0, 1, 0),
            SIMD4<Float>(x, y, z, 1)
        )

        self = matrix_multiply(self, result)
    }

    mutating func scale(axis: SIMD3<Float>) {
        var result = matrix_identity_float4x4

        let x: Float = axis.x
        let y: Float = axis.y
        let z: Float = axis.z

        result.columns = (
            SIMD4<Float>(x, 0, 0, 0),
            SIMD4<Float>(0, y, 0, 0),
            SIMD4<Float>(0, 0, z, 0),
            SIMD4<Float>(0, 0, 0, 1)
        )

        self = matrix_multiply(self, result)
    }


    mutating func rotate(angle: Float, axis: SIMD3<Float>) {
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
            SIMD4<Float>(r1c1, r2c1, r3c1, r4c1),
            SIMD4<Float>(r1c2, r2c2, r3c2, r4c2),
            SIMD4<Float>(r1c3, r2c3, r3c3, r4c3),
            SIMD4<Float>(r1c4, r2c4, r3c4, r4c4)
        )

        self = matrix_multiply(self, result)
    }

}

