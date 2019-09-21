//
//  EKMaterial.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import simd

internal struct EKMaterial: Sizeable {
    internal var strokeColor: SIMD4<Float> = SIMD4<Float>(0, 0, 0, 1)
    internal var fillColor: SIMD4<Float> = SIMD4<Float>(1, 0, 0, 1)
    internal var useTexture: Bool = false
    internal var isCircular: Bool = false

    internal init() {}

    internal init(useTexture: Bool) {
        self.useTexture = useTexture
    }

    internal init(isCircular: Bool) {
        self.isCircular = isCircular
    }
}
