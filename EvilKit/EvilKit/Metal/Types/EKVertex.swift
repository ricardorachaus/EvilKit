//
//  EKVertex.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 03/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import simd

import Quartz

internal struct EKVertex: Sizeable {
    public var position: float3
    public var color: float4
    public var textureCoordinate: float2
}
