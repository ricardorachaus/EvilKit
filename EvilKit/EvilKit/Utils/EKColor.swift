//
//  EKColor.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import MetalKit

open class EKColor {

    public let red: Float
    public let green: Float
    public let blue: Float
    public let alpha: Float

    public static let black = EKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
    public static let white = EKColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    public static let red = EKColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    public static let clear = EKColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)

    internal let metalColor: MTLClearColor
    internal static let defaultColor = EKColor(red: 0.5, green: 0.34, blue: 0.76, alpha: 1)

    public init(red: Float, green: Float, blue: Float, alpha: Float) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
        self.metalColor = MTLClearColor(red: red.asDouble,
                                        green: green.asDouble,
                                        blue: blue.asDouble,
                                        alpha: alpha.asDouble)
    }

    internal func colorVector() -> SIMD4<Float> {
        return SIMD4<Float>(red, green, blue, alpha)
    }
}
