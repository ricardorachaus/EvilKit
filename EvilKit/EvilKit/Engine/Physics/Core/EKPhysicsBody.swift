//
//  EKPhysicsBody.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 10/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import Foundation

import SpriteKit

/**
 A SpriteKit physics body. These are the physical representations of your nodes. These specify the area and mass and any collision masking needed.

 All bodies have zero, one or more shapes that define its area. A body with no shapes is ethereal and does not collide with other bodies.
 */
open class EKPhysicsBody : NSObject {

    open var isDynamic: Bool

    open var usesPreciseCollisionDetection: Bool

    open var allowsRotation: Bool


    /**
     If the physics simulation has determined that this body is at rest it may set the resting property to YES. Resting bodies do not participate
     in the simulation until some collision with a non-resting  object, or an impulse is applied, that unrests it. If all bodies in the world are resting
     then the simulation as a whole is "at rest".
     */
    open var isResting: Bool


    /**
     Determines the 'roughness' for the surface of the physics body (0.0 - 1.0). Defaults to 0.2
     */
    open var friction: CGFloat


    /**
     Determines the 'bounciness' of the physics body (0.0 - 1.0). Defaults to 0.2
     */
    open var restitution: CGFloat


    /**
     Optionally reduce the body's linear velocity each frame to simulate fluid/air friction. Value should be zero or greater. Defaults to 0.1.
     Used in conjunction with per frame impulses, an object can be made to move at a constant speed. For example, if an object 64 points in size
     and default density and a linearDamping of 25 will slide across the screen in a few seconds if an impulse of magnitude 10 is applied every update.
     */
    open var linearDamping: CGFloat


    /**
     Optionally reduce the body's angular velocity each frame to simulate rotational friction. (0.0 - 1.0). Defaults to 0.1
     */
    open var angularDamping: CGFloat


    /**
     The density of the body.
     @discussion
     The unit is arbitrary, as long as the relative densities are consistent throughout the application. Note that density and mass are inherently related (they are directly proportional), so changing one also changes the other. Both are provided so either can be used depending on what is more relevant to your usage.
     */
    open var density: CGFloat


    /**
     The mass of the body.
     @discussion
     The unit is arbitrary, as long as the relative masses are consistent throughout the application. Note that density and mass are inherently related (they are directly proportional), so changing one also changes the other. Both are provided so either can be used depending on what is more relevant to your usage.
     */
    open var mass: CGFloat


    /**
     Bodies are affected by field forces such as gravity if this property is set and the field's category mask is set appropriately. The default value is YES.
     @discussion
     If this is set a force is applied to the object based on the mass. Set the field force vector in the scene to modify the strength of the force.
     */
    open var affectedByGravity: Bool


    /**
     Defines what logical 'categories' this body belongs to. Defaults to all bits set (all categories).
     */
    open var categoryBitMask: UInt32


    /**
     Defines what logical 'categories' of bodies this body responds to collisions with. Defaults to all bits set (all categories).
     */
    open var collisionBitMask: UInt32


    /**
     Defines what logical 'categories' of bodies this body generates intersection notifications with. Defaults to all bits cleared (no categories).
     */
    open var contactTestBitMask: UInt32


    /**
     The representedObject this physicsBody is currently bound to, or nil if it is not.
     */
    weak open var node: EKNode?


    open var velocity: CGVector {
        willSet {
            node?.position.x += newValue.dx
            node?.position.y += newValue.dy
        }
    }

    open var angularVelocity: CGFloat

    internal var shape: EKPhysicsShape?

    public override init() {
        isDynamic = false
        usesPreciseCollisionDetection = false
        allowsRotation = false
        isResting = false
        friction = 0.2
        restitution = 0.2
        linearDamping = 0.1
        angularDamping = 0.1
        density = 0
        mass = 1
        affectedByGravity = true
        categoryBitMask = 0x00
        collisionBitMask = 0x00
        contactTestBitMask = 0x00
        velocity = CGVector.zero
        angularVelocity = 0
        super.init()
    }

    /**
     Creates a circle of radius r centered at the node's origin.
     @param r the radius in points
     */
    public /*not inherited*/ convenience init(circleOfRadius r: CGFloat) {
        self.init()
    }


    /**
     Creates a circle of radius r centered at a point in the node's coordinate space.
     @param r the radius in points
     */
    public /*not inherited*/ convenience init(circleOfRadius r: CGFloat, center: CGPoint) {
        self.init()
    }


    /**
     Creates a rectangle of the specified size centered at the node's origin.
     @param s the size in points
     */
    public /*not inherited*/ convenience init(rectangleOf s: CGSize) {
        self.init()
        self.shape = EKPhysicsBoxShape(physicsBody: self, size: s)
    }


    /**
     Creates a rectangle of the specified size centered at a point in the node's coordinate space.
     @param s the size in points
     */
    public /*not inherited*/ convenience init(rectangleOf s: CGSize, center: CGPoint) {
        self.init()
    }


    /**
     The path must represent a convex or concave polygon with counter clockwise winding and no self intersection. Positions are relative to the node's origin.
     @param path the path to use
     */
    public /*not inherited*/ convenience init(polygonFrom path: CGPath) {
        self.init()
    }


    /**
     Creates an edge from p1 to p2. Edges have no volume and are intended to be used to create static environments. Edges can collide with bodies of volume, but not with each other.
     @param p1 start point
     @param p2 end point
     */
    public /*not inherited*/ convenience init(edgeFrom p1: CGPoint, to p2: CGPoint) {
        self.init()
    }


    /**
     Creates an edge chain from a path. The path must have no self intersection. Edges have no volume and are intended to be used to create static environments. Edges can collide with bodies of volume, but not with each other.
     @param path the path to use
     */
    public /*not inherited*/ convenience init(edgeChainFrom path: CGPath) {
        self.init()
    }


    /**
     Creates an edge loop from a path. A loop is automatically created by joining the last point to the first. The path must have no self intersection. Edges have no volume and are intended to be used to create static environments. Edges can collide with body's of volume, but not with each other.
     @param path the path to use
     */
    public /*not inherited*/ convenience init(edgeLoopFrom path: CGPath) {
        self.init()
    }


    /**
     Creates an edge loop from a CGRect. Edges have no volume and are intended to be used to create static environments. Edges can collide with body's of volume, but not with each other.
     @param rect the CGRect to use
     */
    public /*not inherited*/ convenience init(edgeLoopFrom rect: CGRect) {
        self.init()
    }


    /**
     Creates a body from the alpha values in the supplied texture.
     @param texture the texture to be interpreted
     @param size of the generated physics body
     */
    @available(OSX 10.10, *)
    public /*not inherited*/ convenience init(texture: SKTexture, size: CGSize) {
        self.init()
    }


    /**
     Creates a body from the alpha values in the supplied texture.
     @param texture the texture to be interpreted
     @param alphaThreshold the alpha value above which a pixel is interpreted as opaque
     @param size of the generated physics body
     */
    @available(OSX 10.10, *)
    public /*not inherited*/ convenience init(texture: SKTexture, alphaThreshold: Float, size: CGSize) {
        self.init()
    }


    /**
     Creates an compound body that is the union of the bodies used to create it.
     */
    public /*not inherited*/ convenience init(bodies: [SKPhysicsBody]) {
        self.init()
    }

    open func applyForce(_ force: CGVector) {

    }

    open func applyForce(_ force: CGVector, at point: CGPoint) {

    }


    open func applyTorque(_ torque: CGFloat) {

    }

    open func applyImpulse(_ impulse: CGVector) {

    }

    open func applyImpulse(_ impulse: CGVector, at point: CGPoint) {

    }

    open func applyAngularImpulse(_ impulse: CGFloat) {

    }

    /* Returns an array of all SKPhysicsBodies currently in contact with this one */
    open func allContactedBodies() -> [EKPhysicsBody] {
        return []
    }
}
