//
//  EKTextureFilteringMode.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 03/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import MetalKit

public enum EKTextureFilteringMode: Int {
    case nearest
    case linear

    internal func samplerFilter() -> MTLSamplerMinMagFilter {
        switch self {
        case .linear:
            return .linear
        case .nearest:
            return .nearest
        }
    }
}
