//
//  EKScene.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import MetalKit
import AVFoundation

import SpriteKit

open class EKScene: EKNode {

    open var size: CGSize

    /**
     The camera that is used to obtain the view scale and translation based on where the camera is in relation to the scene.
     */
    open var camera: EKCameraNode? {
        willSet {
            if let camera = newValue {
                addChild(camera)
            }
        }
    }

    /**
     The audio engine that the listener and the scene's audio nodes use to process their sound through.
     */
    internal(set) open var audioEngine: AVAudioEngine

    /**
     Background color, defaults to gray
     */
    open var backgroundColor: EKColor

    /**
     Used to choose the origin of the scene's coordinate system
     */
    open var anchorPoint: CGPoint


    /**
     The SKView this scene is currently presented in, or nil if it is not being presented.
     */
    internal(set) weak open var view: EKView?

    internal var sceneTransform: EKSceneTransform

    /**
     A scene is infinitely large, but it has a viewport that is the frame through which you present the content of the scene.
     The passed in size defines the size of this viewport that you use to present the scene.

     @param size a size in points that signifies the viewport into the scene that defines your framing of the scene.
     */
    public init(size: CGSize) {
        self.size = size
        self.audioEngine = AVAudioEngine()
        self.backgroundColor = EKColor.defaultColor
        self.anchorPoint = CGPoint.zero
        self.sceneTransform = EKSceneTransform()
        super.init()
    }

    public required init?(coder: NSCoder) {
        self.size = CGSize.zero
        self.audioEngine = AVAudioEngine()
        self.backgroundColor = EKColor.defaultColor
        self.anchorPoint = CGPoint.zero
        self.sceneTransform = EKSceneTransform()
        super.init(coder: coder)
    }

    /* This is called once after the scene has been initialized or decoded,
     this is the recommended place to perform one-time setup */
    @available(OSX 10.12, *)
    open func sceneDidLoad() {}

    /**
     Override this to perform per-frame game logic. Called exactly once per frame before any actions are evaluated and any physics are simulated.

     @param currentTime the current time in the app. This must be monotonically increasing.
     */
    open func update(_ currentTime: TimeInterval) {}

    open func didMove(to view: EKView) {}

    open func willMove(from view: EKView) {}

    open func didChangeSize(_ oldSize: CGSize) {}

    open override func addChild(_ node: EKNode) {
        super.addChild(node)
        node.scene = self
    }

    internal func updateScene() {
        if let camera = camera {
            sceneTransform.viewMatrix = camera.viewMatrix
            sceneTransform.projectionMatrix = camera.projectionMatrix
        }
    }

    override internal func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        updateScene()
        renderCommandEncoder.setVertexBytes(&sceneTransform, length: EKSceneTransform.stride, index: 1)
        super.render(renderCommandEncoder: renderCommandEncoder)
    }

}
