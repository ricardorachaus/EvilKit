//
//  EKView.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 01/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import MetalKit
import SpriteKit

open class EKView: MTKView {
    
    
    /**
     Toggles display of performance stats in the view. All default to false.
     */
    open var showsFPS: Bool
    
    open var showsDrawCount: Bool
    
    open var showsNodeCount: Bool
    
    
    /**
     Toggles whether the view updates is rendered asynchronously or aligned with Core Animation updates. Defaults to YES.
     */
    open var isAsynchronous: Bool
    
    
    /**
     Ignores sibling and traversal order to sort the rendered contents of a scene into the most efficient batching possible.
     This will require zPosition to be used in the scenes to properly guarantee elements are in front or behind each other.
     
     This defaults to NO, meaning that sibling order overrides efficiency heuristics in the rendering of the scenes in the view.
     
     Setting this to YES for a complex scene may substantially increase performance, but care must be taken as only zPosition
     determines render order before the efficiency heuristics are used.
     */
    open var ignoresSiblingOrder: Bool
    
    /**
     The currently presented scene, otherwise nil. If in a transition, the 'incoming' scene is returned.
     */
    open var scene: EKScene? {
        return scenes.first
    }
    
    
    private var scenes: [EKScene]
    
    
    init(frame: CGRect) {
        let device = MTLCreateSystemDefaultDevice()
        showsFPS = false
        showsDrawCount = false
        showsNodeCount = false
        isAsynchronous = false
        ignoresSiblingOrder = false
        scenes = []
        super.init(frame: frame, device: device)
    }
    
    public required init(coder: NSCoder) {
        showsFPS = false
        showsDrawCount = false
        showsNodeCount = false
        isAsynchronous = false
        ignoresSiblingOrder = false
        scenes = []
        super.init(coder: coder)
    }
    
    /**
     Present an EKScene in the view, replacing the current scene.
     
     @param scene the scene to present.
     */
    open func presentScene(_ scene: EKScene?) {
        if let scene = scene {
            scenes.insert(scene, at: scenes.startIndex)
        }
    }
    
    
    /**
     Present an EKScene in the view, replacing the current scene.
     
     If there is currently a scene being presented in the view, the transition is used to swap between them.
     
     @param scene the scene to present.
     @param transition the transition to use when presenting the scene.
     */
    open func presentScene(_ scene: EKScene, transition: SKTransition) {
        
    }
    
    
    /**
     Converts a point from view space to scene space.
     
     @param point the point to convert.
     @param scene the scene to convert the point into.
     */
    open func convert(_ point: CGPoint, to scene: EKScene) -> CGPoint {
        return CGPoint.zero
    }
    
    
    /**
     Converts a point from scene space to view space.
     
     @param point the point to convert.
     @param scene the scene to convert the point into.
     */
    open func convert(_ point: CGPoint, from scene: EKScene) -> CGPoint {
        return CGPoint.zero
    }
    
}

@available(OSX 10.12, *)
public protocol EKViewDelegate : NSObjectProtocol {
    
    
    /**
     Allows the client to dynamically control the render rate.
     
     return YES to initiate an update and render for the target time.
     return NO to skip update and render for this target time.
     */
    func view(_ view: EKView, shouldRenderAtTime time: TimeInterval) -> Bool
}

