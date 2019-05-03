//
//  EKScene.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 01/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import MetalKit
import SpriteKit
import AVFoundation

open class EKScene: EKNode {
    
    open var size: CGSize
    
    /**
     Used to determine how to scale the scene to match the SKView it is being displayed in.
     */
    open var scaleMode: SKSceneScaleMode
    
    
    /**
     The camera that is used to obtain the view scale and translation based on where the camera is in relation to the scene.
     */
    weak open var camera: SKCameraNode?
    
    
    /**
     The node that is currently the listener for positional audio coming from SKAudioNodes
     @see SKAudioNode
     */
    weak open var listener: SKNode?
    
    /**
     The audio engine that the listener and the scene's audio nodes use to process their sound through.
     */
    private(set) open var audioEngine: AVAudioEngine
    
    /**
     Background color, defaults to gray
     */
    open var backgroundColor: NSColor
    
    weak open var delegate: SKSceneDelegate?
    
    
    /**
     Used to choose the origin of the scene's coordinate system
     */
    open var anchorPoint: CGPoint
    
    
    /**
     Physics simulation functionality
     */
    private(set) open var physicsWorld: SKPhysicsWorld
    
    
    /**
     The SKView this scene is currently presented in, or nil if it is not being presented.
     */
    private(set) weak open var view: SKView?
    
    /**
     A scene is infinitely large, but it has a viewport that is the frame through which you present the content of the scene.
     The passed in size defines the size of this viewport that you use to present the scene.
     
     @param size a size in points that signifies the viewport into the scene that defines your framing of the scene.
     */
    public init(size: CGSize) {
        self.size = size
        self.scaleMode = .aspectFill
        self.audioEngine = AVAudioEngine()
        self.backgroundColor = .black
        self.anchorPoint = CGPoint.zero
        self.physicsWorld = SKPhysicsWorld()
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.size = CGSize.zero
        self.scaleMode = .aspectFill
        self.audioEngine = AVAudioEngine()
        self.backgroundColor = .black
        self.anchorPoint = CGPoint.zero
        self.physicsWorld = SKPhysicsWorld()
        super.init(coder: aDecoder)
    }
    
    /* This is called once after the scene has been initialized or decoded,
     this is the recommended place to perform one-time setup */
    @available(OSX 10.12, *)
    open func sceneDidLoad() {
        
    }
    
    /**
     Override this to perform per-frame game logic. Called exactly once per frame before any actions are evaluated and any physics are simulated.
     
     @param currentTime the current time in the app. This must be monotonically increasing.
     */
    open func update(_ currentTime: TimeInterval) {
        
    }
    
    
    /**
     Override this to perform game logic. Called exactly once per frame after any actions have been evaluated but before any physics are simulated. Any additional actions applied is not evaluated until the next update.
     */
    open func didEvaluateActions() {
        
    }
    
    
    /**
     Override this to perform game logic. Called exactly once per frame after any actions have been evaluated and any physics have been simulated. Any additional actions applied is not evaluated until the next update. Any changes to physics bodies is not simulated until the next update.
     */
    open func didSimulatePhysics() {
        
    }
    
    
    /**
     Override this to perform game logic. Called exactly once per frame after any enabled constraints have been applied. Any additional actions applied is not evaluated until the next update. Any changes to physics bodies is not simulated until the next update. Any changes to constarints will not be applied until the next update.
     */
    @available(OSX 10.10, *)
    open func didApplyConstraints() {
        
    }
    
    
    /**
     Override this to perform game logic. Called after all update logic has been completed. Any additional actions applied are not evaluated until the next update. Any changes to physics bodies are not simulated until the next update. Any changes to constarints will not be applied until the next update.
     
     No futher update logic will be applied to the scene after this call. Any values set on nodes here will be used when the scene is rendered for the current frame.
     */
    @available(OSX 10.10, *)
    open func didFinishUpdate() {
        
    }
    
    
    open func didMove(to view: SKView) {
        
    }
    
    open func willMove(from view: SKView) {
        
    }
    
    
    open func didChangeSize(_ oldSize: CGSize) {
        
    }

    
}
