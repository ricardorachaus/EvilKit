//
//  DefaultDevice.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 03/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import MetalKit

internal struct GPU {
    internal static let device = MTLCreateSystemDefaultDevice()!
}
