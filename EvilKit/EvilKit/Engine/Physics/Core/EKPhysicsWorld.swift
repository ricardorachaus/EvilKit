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
    
    private func calculateGravityForce(for body: EKPhysicsBody) -> CGVector {
        return CGVector(dx: body.mass * gravity.dx,
                        dy: body.mass * gravity.dy)
    }

    private func AABBOverlap(between bodyA: EKAABB, and bodyB: EKAABB) -> Bool {
        if ((bodyA.max.dx < bodyB.min.dx) || (bodyA.min.dx > bodyB.max.dx)) {
            return false
        }
        if ((bodyA.max.dy < bodyB.min.dy) || (bodyA.min.dy > bodyB.max.dy)) {
            return false
        }
        return true
    }
    
    private func circleCollision(between bodyA: EKCircle, and bodyB: EKCircle) -> Bool {
        let squareX = pow((bodyA.position.dx - bodyB.position.dx), 2)
        let squareY = pow((bodyA.position.dy - bodyB.position.dy), 2)
        var r = bodyA.radius + bodyB.radius
        r *= r
        return r < squareX + squareY
    }
    
    private func resolveCollision(bodyA: EKPhysicsBody, bodyB: EKPhysicsBody) {
        // Relative velocity
        let rv = CGVector(dx: bodyB.velocity.dx - bodyA.velocity.dx,
                          dy: bodyB.velocity.dy - bodyA.velocity.dy)
        let normal = CGVector(dx: 0, dy: 0)
        
        // Relative velocity in terms of normal
        let velocityAlongNormal = dotProduct(x: rv,
                                             y: normal)
        
        if velocityAlongNormal > 0 {
            return
        }
        
        // Calculate restitution
        let e = min(bodyA.restitution, bodyB.restitution)
        
        // Calculate impulse scalar
        var j = -(1 * e) * velocityAlongNormal
        j /= (1 / bodyA.mass) + (1 / bodyB.mass)
        
        // Apply impulse
        let impulse = CGVector(dx: j * normal.dx,
                               dy: j * normal.dy)
        
        bodyA.velocity.dx -= (1 / bodyA.mass) * impulse.dx
        bodyA.velocity.dy -= (1 / bodyA.mass) * impulse.dy
        
        bodyB.velocity.dx += (1 / bodyB.mass) * impulse.dx
        bodyB.velocity.dy += (1 / bodyB.mass) * impulse.dy
    }
    
    private func dotProduct(x: CGVector, y: CGVector) -> CGFloat {
        return (x.dx * y.dx) + (x.dy * y.dy)
    }

}
