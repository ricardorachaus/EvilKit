//
//  EKPhysicsShape.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 13/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import Foundation

internal protocol EKPhysicsShape {
    var physicsBody: EKPhysicsBody? { get set }

    func calculateInertia() -> CGFloat
    func computeTorque(with f: CGVector) -> CGFloat
    func angularAcceleration(with force: CGVector) -> CGFloat
}

internal extension EKPhysicsShape {
    func angularAcceleration(with force: CGVector) -> CGFloat {
        return computeTorque(with: force) / calculateInertia()
    }
}

internal struct EKPhysicsBoxShape: EKPhysicsShape {

    internal var size: CGSize
    internal weak var physicsBody: EKPhysicsBody?

    internal init(physicsBody: EKPhysicsBody, size: CGSize) {
        self.size = size
        self.physicsBody = physicsBody
    }

    internal func calculateInertia() -> CGFloat {
        if let body = physicsBody {
            let m = body.mass
            let w = size.width
            let h = size.height
            return m * (w * w + h * h) / 12
        }
        return 0
    }

    internal func computeTorque(with f: CGVector) -> CGFloat {
        let r = CGVector(dx: size.width / 2,
                         dy: size.height / 2)
        return r.dx * f.dy - r.dy * f.dx
    }

}
