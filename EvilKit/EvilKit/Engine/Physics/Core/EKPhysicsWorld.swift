//
//  EKPhysicsWorld.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 10/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import Foundation
import SpriteKit

open class EKPhysicsWorld: NSObject {

    /**
     A global 2D vector specifying the field force acceleration due to gravity. The unit is meters per second so standard earth gravity would be { 0.0, +/-9.8 }.
     */
    open var gravity: CGVector

    /**
     The rate at which the simulation executes.
    */
    open var speed: CGFloat

    unowned(unsafe) open var contactDelegate: EKPhysicsContactDelegate?

    internal var bodies: [EKPhysicsBody]
    
    private var previousTime: TimeInterval = 0

    public override init() {
        gravity = CGVector(dx: 0, dy: -9.8)
        speed = 1
        bodies = []
        super.init()
    }

    internal func update(currentTime: TimeInterval) {
        let dt = (currentTime - previousTime).asCGFloat
        previousTime = currentTime

        for body in bodies {
            updatePhysics(for: body, with: dt)
        }
    }

    private func calculateGravityForce(for body: EKPhysicsBody) -> CGVector {
        return CGVector(dx: body.mass * gravity.dx,
                        dy: body.mass * gravity.dy)
    }

    private func updatePhysics(for body: EKPhysicsBody, with dt: CGFloat) {
        let slowDownFactor = 0.005.asCGFloat
        let force = calculateGravityForce(for: body)
        let acceleration = CGVector(dx: force.dx / body.mass,
                                    dy: force.dy / body.mass)

        body.velocity.dx += acceleration.dx * dt * slowDownFactor
        body.velocity.dy += acceleration.dy * dt * slowDownFactor

        // TODO: - Finish angular physics
//        let angularAcceleration = body.shape?.angularAcceleration(with: force)
//        if let angularAcceleration = angularAcceleration {
//            body.angularVelocity += angularAcceleration * dt
//        }
    }

    private func TestAABBOverlap(bodyA: EKAABB, bodyB: EKAABB) -> Bool {
        let d1x = bodyB.min.dx - bodyA.max.dx
        let d1y = bodyB.min.dy - bodyA.max.dy
        let d2x = bodyA.min.dx - bodyB.max.dx
        let d2y = bodyA.min.dx - bodyB.max.dy

        if (d1x > 0 || d1y > 0) {
            return false
        }

        if (d2x > 0 || d2y > 0) {
            return false
        }

        return true
    }

}
