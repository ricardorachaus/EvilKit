//
//  EKMaterial.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import simd

internal struct EKMaterial: Sizeable {
    internal var color: float4 = float4(1, 0, 0, 1)
    internal var useMaterialColor: Bool = false
    internal var useTexture: Bool = false

    internal init() {}

    internal init(useTexture: Bool) {
        self.useTexture = useTexture
    }
}
