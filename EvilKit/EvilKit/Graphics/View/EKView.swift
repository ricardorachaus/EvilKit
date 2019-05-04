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
     The currently presented scene, otherwise nil. If in a transition, the 'incoming' scene is returned.
     */
    open var scene: EKScene? {
        return scenes.first
    }
    
    private var currentTime: TimeInterval = 0
    private var scenes: [EKScene]
    private let renderer: EKRenderer
    
    init(frame: CGRect) {
        renderer = EKRenderer(device: GPU.device)
        scenes = []
        super.init(frame: frame, device: GPU.device)
    }
    
    public required init(coder: NSCoder) {
        renderer = EKRenderer(device: GPU.device)
        scenes = []
        super.init(coder: coder)
    }
    
    /**
     Present an EKScene in the view, replacing the current scene.
     
     @param scene the scene to present.
     */
    open func presentScene(_ scene: EKScene?) {
        if let scene = scene {
            scene.view = self
            scenes.insert(scene, at: scenes.startIndex)
        }
    }
    
}

extension EKView: MTKViewDelegate {

    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        scene?.didChangeSize(view.drawableSize)
    }

    public func draw(in view: MTKView) {
        guard let renderPassDescriptor = view.currentRenderPassDescriptor,
              let drawable = view.currentDrawable,
              let commandBuffer = renderer.commandQueue?.makeCommandBuffer() else {
            return
        }

        renderer.renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)

        currentTime += 1 / Double(view.preferredFramesPerSecond)
        renderer.update(atTime: currentTime)
        scene?.update(currentTime)

        renderer.render(withViewport: view.bounds.standardized, commandBuffer: commandBuffer, renderPassDescriptor: renderPassDescriptor)

        commandBuffer.present(drawable)
        commandBuffer.commit()
    }
}
