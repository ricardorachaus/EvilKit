//
//  EKRenderer.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import MetalKit

open class EKRenderer : NSObject {

    /**
     The currently presented scene, otherwise nil. If in a transition, the 'incoming' scene is returned.
     */
    open var scene: EKScene?

    internal var device: MTLDevice
    internal var renderPipelineState: MTLRenderPipelineState?

    /**
     Creates a renderer with the specified Metal device.

     @param device A Metal device.
     @return A new renderer object.
     */
    public /*not inherited*/ init(device: MTLDevice) {
        self.device = device
        super.init()
        setup()
    }

    /**
     Render the scene content in the specified Metal command buffer.

     @param viewport The pixel dimensions in which to render.
     @param commandBuffer The Metal command buffer in which SpriteKit should schedule rendering commands.
     @param renderPassDescriptor The Metal render pass descriptor describing the rendering target.
     */
    open func render(withViewport viewport: CGRect, commandBuffer: MTLCommandBuffer, renderPassDescriptor: MTLRenderPassDescriptor) {
        let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        if let renderCommandEncoder = renderCommandEncoder,
            let renderPipelineState = renderPipelineState {
            renderCommandEncoder.setRenderPipelineState(renderPipelineState)
            scene?.render(renderCommandEncoder: renderCommandEncoder)
        }
        renderCommandEncoder?.endEncoding()
    }


    /**
     Update the scene at the specified system time.

     @param currentTime The timestamp in seconds.
     */
    open func update(atTime currentTime: TimeInterval) {
        scene?.update(currentTime)
        scene?.physicsWorld.update(currentTime: currentTime)
    }

    private func setup() {
        var library: MTLLibrary!
        guard let bundle = Bundle(identifier: "rachaus.EvilKit") else {
            fatalError("Couldn't find bundle.")
        }
        do {
            library = try device.makeDefaultLibrary(bundle: bundle)
        } catch {
            print(error.localizedDescription)
        }

        let vertexDescriptor = MTLVertexDescriptor()

        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0

        vertexDescriptor.attributes[1].format = .float2
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = SIMD3<Float>.size

        vertexDescriptor.layouts[0].stride = EKVertex.stride

        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm_srgb
        renderPipelineDescriptor.vertexFunction = library.makeFunction(name: "default_vertex_shader")
        renderPipelineDescriptor.fragmentFunction = library.makeFunction(name: "default_fragment_shader")
        renderPipelineDescriptor.vertexDescriptor = vertexDescriptor

        renderPipelineDescriptor.colorAttachments[0].rgbBlendOperation = .add
        renderPipelineDescriptor.colorAttachments[0].alphaBlendOperation = .add
        renderPipelineDescriptor.colorAttachments[0].sourceRGBBlendFactor = .sourceAlpha
        renderPipelineDescriptor.colorAttachments[0].sourceAlphaBlendFactor = .sourceAlpha

        renderPipelineDescriptor.colorAttachments[0].destinationRGBBlendFactor = .oneMinusSourceAlpha
        renderPipelineDescriptor.colorAttachments[0].destinationAlphaBlendFactor = .oneMinusSourceAlpha

        do {
            renderPipelineState = try device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch {
            print(error.localizedDescription)
        }
    }

}
