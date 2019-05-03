//
//  EKNode.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 01/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import Foundation

import SpriteKit

open class EKNode : NSResponder {
    
    /**
     The position of the node in the parent's coordinate system
     */
    open var position: CGPoint
    
    /**
     The z-order of the node (used for ordering). Negative z is "into" the screen, Positive z is "out" of the screen. A greater zPosition will sort in front of a lesser zPosition.
     */
    open var zPosition: CGFloat
    
    /**
     The Euler rotation about the z axis (in radians)
     */
    open var zRotation: CGFloat
    
    /**
     The scaling in the X axis
     */
    open var xScale: CGFloat
    
    /**
     The scaling in the Y axis
     */
    open var yScale: CGFloat
    
    /**
     The speed multiplier applied to all actions run on this node. Inherited by its children.
     */
    open var speed: CGFloat
    
    /**
     Alpha of this node (multiplied by the output color to give the final result)
     */
    open var alpha: CGFloat
    
    /**
     Controls whether or not the node's actions is updated or paused.
     */
    open var isPaused: Bool
    
    /**
     Controls whether or not the node and its children are rendered.
     */
    open var isHidden: Bool
    
    /**
     Controls whether or not the node receives touch events
     */
    open var isUserInteractionEnabled: Bool
    
    /**
     The parent of the node.
     
     If this is nil the node has not been added to another group and is thus the root node of its own graph.
     */
    private(set) open var parent: EKNode?
    
    /**
     The children of this node.
     */
    private(set) open var children: [EKNode]
    
    /**
     The client assignable name.
     
     In general, this should be unique among peers in the scene graph.
     */
    open var name: String?
    
    /**
     The scene that the node is currently in.
     */
    private(set) open var scene: EKScene?
    
    /**
     Physics body attached to the node, with synchronized scale, rotation, and position
     */
    open var physicsBody: EKPhysicsBody?
    
    public override init() {
        self.position = CGPoint.zero
        self.zPosition = 0
        self.zRotation = 0
        self.xScale = 0
        self.yScale = 0
        self.speed = 0
        self.alpha = 0
        self.isPaused = false
        self.isHidden = false
        self.isUserInteractionEnabled = false
        self.children = []
        super.init()
    }
    
    
    /**
     Support coding and decoding via NSKeyedArchiver.
     */
    public required init?(coder aDecoder: NSCoder) {
        self.position = CGPoint.zero
        self.zPosition = 0
        self.zRotation = 0
        self.xScale = 0
        self.yScale = 0
        self.speed = 0
        self.alpha = 0
        self.isPaused = false
        self.isHidden = false
        self.isUserInteractionEnabled = false
        self.children = []
        super.init(coder: aDecoder)
    }
    
    /**
     Sets both the x & y scale
     
     @param scale the uniform scale to set.
     */
    open func setScale(_ scale: CGFloat) {
        
    }
    
    /**
     Adds a node as a child node of this node
     
     The added node must not have a parent.
     
     @param node the child node to add.
     */
    open func addChild(_ node: EKNode) {
        children.append(node)
    }
    
    open func insertChild(_ node: EKNode, at index: Int) {
        children.insert(node, at: index)
    }
    
    open func removeChildren(in nodes: [EKNode]) {
        children.forEach { child in
            nodes.forEach { node in
                if child == node {
                    child.removeFromParent()
                }
            }
        }
    }
    
    open func removeAllChildren() {
        children.removeAll()
    }
    
    open func removeFromParent() {
        parent?.children.removeAll { $0 == self }
        parent = nil
    }
    
    @available(OSX 10.11, *)
    open func move(toParent parent: EKNode) {
        self.parent = parent
    }
    
    open func childNode(withName name: String) -> EKNode? {
        let node = children.first { child in
            guard let name = child.name else {
                return false
            }
            return name.elementsEqual(name)
        }
        return node
    }
    
    open func run(_ action: EKAction) {
        
    }
    
    open func run(_ action: EKAction, completion block: @escaping () -> Void) {
        
    }
    
    open func run(_ action: EKAction, withKey key: String) {
        
    }
    
    open func hasActions() -> Bool {
        return false
    }
    
    open func action(forKey key: String) -> EKAction? {
        return nil
    }
    
    
    open func removeAction(forKey key: String) {
        
    }
    
    open func removeAllActions() {
        
    }
    
}

