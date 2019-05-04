//
//  EKScene.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 01/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import MetalKit
import AVFoundation

open class EKScene: EKNode {
    
    open var size: CGSize
    
    /**
     The camera that is used to obtain the view scale and translation based on where the camera is in relation to the scene.
     */
    weak open var camera: EKCameraNode?
    
    /**
     The audio engine that the listener and the scene's audio nodes use to process their sound through.
     */
    internal(set) open var audioEngine: AVAudioEngine
    
    /**
     Background color, defaults to gray
     */
    open var backgroundColor: NSColor
    
    /**
     Used to choose the origin of the scene's coordinate system
     */
    open var anchorPoint: CGPoint
    
    
    /**
     The SKView this scene is currently presented in, or nil if it is not being presented.
     */
    internal(set) weak open var view: EKView?

    internal var sceneModel: EKSceneModel
    
    /**
     A scene is infinitely large, but it has a viewport that is the frame through which you present the content of the scene.
     The passed in size defines the size of this viewport that you use to present the scene.
     
     @param size a size in points that signifies the viewport into the scene that defines your framing of the scene.
     */
    public init(size: CGSize) {
        self.size = size
        self.audioEngine = AVAudioEngine()
        self.backgroundColor = .black
        self.anchorPoint = CGPoint.zero
        self.sceneModel = EKSceneModel()
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.size = CGSize.zero
        self.audioEngine = AVAudioEngine()
        self.backgroundColor = .black
        self.anchorPoint = CGPoint.zero
        self.sceneModel = EKSceneModel()
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

    open func didMove(to view: EKView) {
        
    }
    
    open func willMove(from view: EKView) {
        
    }

    open func didChangeSize(_ oldSize: CGSize) {
        
    }

    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&sceneModel, length: EKSceneModel.stride, index: 1)
    }
    
}
