//
//  EKVertex.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import simd

internal struct EKVertex: Sizeable {
    internal var position: float3
    internal var color: float4
    internal var textureCoordinate: float2
}
