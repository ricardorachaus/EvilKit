//
//  EKView.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import MetalKit

open class EKView: MTKView {

    open override var acceptsFirstResponder: Bool {
        return true
    }

    /**
     The currently presented scene, otherwise nil. If in a transition, the 'incoming' scene is returned.
     */
    private(set) open var scene: EKScene? {
        willSet {
            renderer?.scene = newValue
            newValue?.view = self
        }
    }


    private var currentTime: TimeInterval = 0
    private var scenes: [EKScene]
    private var renderer: EKRenderer?
    private var commandQueue: MTLCommandQueue?

    public init(frame: CGRect) {
        self.scenes = []
        super.init(frame: frame, device: GPU.device)
        setupView()
    }

    public required init(coder: NSCoder) {
        self.scenes = []
        super.init(coder: coder)
        self.device = GPU.device
        setupView()
    }

    /**
     Present an SKScene in the view, replacing the current scene.

     @param scene the scene to present.
     */
    open func presentScene(_ scene: EKScene?) {
        self.scene = scene
        if let scene = scene {
            clearColor = scene.backgroundColor
            scenes.append(scene)
        }
    }

    private func setupView() {
        self.commandQueue = GPU.device.makeCommandQueue()
        self.colorPixelFormat = .bgra8Unorm_srgb
        self.renderer = EKRenderer(device: GPU.device)
        self.clearColor = EKColor.black.metalColor
        self.delegate = self
    }

}

extension EKView: MTKViewDelegate {

    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        scene?.didChangeSize(view.bounds.size)
    }

    public func draw(in view: MTKView) {
        guard let renderPassDescriptor = view.currentRenderPassDescriptor,
              let drawable = view.currentDrawable,
              let commandBuffer = commandQueue?.makeCommandBuffer() else {
                return
        }

        currentTime += 1 / Double(view.preferredFramesPerSecond)
        renderer?.update(atTime: currentTime)

        renderer?.render(withViewport: CGRect.zero, commandBuffer: commandBuffer, renderPassDescriptor: renderPassDescriptor)
        commandBuffer.present(drawable)
        commandBuffer.commit()
    }

}
