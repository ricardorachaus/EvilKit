//
//  EKColor.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 04/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import MetalKit

public struct EKColor {
    public static let black = MTLClearColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    public static let white = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    public static let red = MTLClearColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    public static let clear = MTLClearColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
}
