//
//  EKNode.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 01/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import Foundation

open class EKNode : NSResponder, NSCopying, NSSecureCoding {
    public func copy(with zone: NSZone? = nil) -> Any {
        return EKNode()
    }
    
    public static var supportsSecureCoding: Bool = false
    
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
        super.init(coder: aDecoder)
    }
    
    
    open var frame: CGRect {
        return CGRect.zero
    }
    
    
    /**
     Calculates the bounding box including all child nodes in parents coordinate system.
     */
    open func calculateAccumulatedFrame() -> CGRect {
        return CGRect.zero
    }
    
    
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
    open var parent: EKNode? {
        return nil
    }
    
    
    /**
     The children of this node.
     
     */
    open var children: [EKNode] {
        return []
    }
    
    
    /**
     The client assignable name.
     
     In general, this should be unique among peers in the scene graph.
     */
    open var name: String?
    
    
    /**
     The scene that the node is currently in.
     */
    open var scene: EKScene? {
        return nil
    }
    
    
    /**
     Physics body attached to the node, with synchronized scale, rotation, and position
     */
    open var physicsBody: EKPhysicsBody?
    
    
    /**
     An optional dictionary that can be used to store your own data in a node. Defaults to nil.
     */
    open var userData: NSMutableDictionary?
    
    
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
        
    }
    
    
    open func insertChild(_ node: EKNode, at index: Int) {
        
    }
    
    
    open func removeChildren(in nodes: [EKNode]) {
        
    }
    
    open func removeAllChildren() {
        
    }
    
    open func removeFromParent() {
        
    }
    
    @available(OSX 10.11, *)
    open func move(toParent parent: EKNode) {
        
    }
    
    
    open func childNode(withName name: String) -> EKNode? {
        return nil
    }
    
    
    /* Returns true if the specified parent is in this node's chain of parents */
    
    open func inParentHierarchy(_ parent: EKNode) -> Bool {
        return false
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
    
    
    open func contains(_ p: CGPoint) -> Bool {
        return false
    }
    
    
    /**Returns the node itself or a child node at the point given.
     * If the receiver is returned there is no child node at the given point.
     * @return a child node or self at the given location.
     */
    open func atPoint(_ p: CGPoint) -> EKNode {
        return EKNode()
    }
    
    
    open func nodes(at p: CGPoint) -> [EKNode] {
        return []
    }
    
    
    open func convert(_ point: CGPoint, from node: EKNode) -> CGPoint {
        return CGPoint.zero
    }
    
    open func convert(_ point: CGPoint, to node: EKNode) -> CGPoint {
        return CGPoint.zero
    }
    
    
    /* Returns true if the bounds of this node intersects with the transformed bounds of the other node, otherwise false */
    
    open func intersects(_ node: EKNode) -> Bool {
        return false
    }
    
    
    /* Returns true if this node has equivalent content to the other object, otherwise false */
    
    open func isEqual(to node: EKNode) -> Bool {
        return false
    }
}

