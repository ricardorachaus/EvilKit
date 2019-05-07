//
//  EKSceneTransform.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import simd

internal struct EKSceneTransform: Sizeable {
    internal var viewMatrix = matrix_identity_float4x4
    internal var projectionMatrix = matrix_identity_float4x4
}
