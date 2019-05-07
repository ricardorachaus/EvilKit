//
//  GPU.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import Foundation

internal struct GPU {
    static let device = MTLCreateSystemDefaultDevice()!
}
