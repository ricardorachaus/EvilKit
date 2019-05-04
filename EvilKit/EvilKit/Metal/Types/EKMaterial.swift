//
//  EKMaterial.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 03/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import simd

internal struct EKMaterial: Sizeable {
    var color = float4(0.0, 0.0, 0.0, 1.0)
    var useColor = false
    var useTexture = false
}
