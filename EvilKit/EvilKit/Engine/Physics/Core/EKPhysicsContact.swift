//
//  EKPhysicsContact.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 10/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import Foundation

open class EKPhysicsContact: NSObject {

    private(set) open var bodyA: EKPhysicsBody

    private(set) open var bodyB: EKPhysicsBody

    private(set) open var contactPoint: CGPoint

    private(set) open var contactNormal: CGVector

    private(set) open var collisionImpulse: CGFloat

    public override init() {
        bodyA = EKPhysicsBody()
        bodyB = EKPhysicsBody()
        contactPoint = CGPoint.zero
        contactNormal = CGVector.zero
        collisionImpulse = 0
        super.init()
    }
}

