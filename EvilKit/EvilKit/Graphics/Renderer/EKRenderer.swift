//
//  EKRenderer.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 03/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import MetalKit

import SpriteKit

open class EKRenderer: NSObject {

    /**
     The currently presented scene, otherwise nil. If in a transition, the 'incoming' scene is returned.
     */
    open var scene: EKScene?
    
    internal let commandQueue: MTLCommandQueue?
    internal var renderCommandEncoder: MTLRenderCommandEncoder?

    private let device: MTLDevice
    private var library: MTLLibrary?
    private var vertexFunction: MTLFunction?
    private var fragmentFunction: MTLFunction?
    private var pipelineDescriptor: MTLRenderPipelineDescriptor?
    private var pipelineState: MTLRenderPipelineState?
    private var depthStencilState: MTLDepthStencilState?

    /**
     Creates a renderer with the specified Metal device.

     @param device A Metal device.
     @return A new renderer object.
     */
    public /*not inherited*/ init(device: MTLDevice) {
        self.device = device
        self.commandQueue = device.makeCommandQueue()
        guard let bundle = Bundle(identifier: "rachaus.EvilKit") else {
            fatalError("Couldn't find bundle.")
        }
        do {
            self.library = try device.makeDefaultLibrary(bundle: bundle)
        } catch {
            print(error.localizedDescription)
        }
        super.init()
        setupDefaultRenderer()
    }

    /**
     Render the scene content in the specified Metal command buffer.

     @param viewport The pixel dimensions in which to render.
     @param commandBuffer The Metal command buffer in which SpriteKit should schedule rendering commands.
     @param renderPassDescriptor The Metal render pass descriptor describing the rendering target.
     */
    open func render(withViewport viewport: CGRect, commandBuffer: MTLCommandBuffer, renderPassDescriptor: MTLRenderPassDescriptor) {
        if let renderCommandEncoder = renderCommandEncoder,
           let pipelineState = pipelineState,
           let depthStencilState = depthStencilState {
            renderCommandEncoder.setRenderPipelineState(pipelineState)
            renderCommandEncoder.setDepthStencilState(depthStencilState)
            scene?.render(renderCommandEncoder: renderCommandEncoder)
            renderCommandEncoder.endEncoding()
        }
    }

    /**
     Update the scene at the specified system time.

     @param currentTime The timestamp in seconds.
     */
    open func update(atTime currentTime: TimeInterval) {
        scene?.update(currentTime)
    }

    // MARK: - Private methods

    private func setupDefaultRenderer() {
        let pipelineDescriptor = MTLRenderPipelineDescriptor()
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        let vertexDescriptor = MTLVertexDescriptor()

        vertexFunction = library?.makeFunction(name: "default_vertex_shader")
        fragmentFunction = library?.makeFunction(name: "default_fragment_shader")

        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].bufferIndex = 0
        vertexDescriptor.attributes[0].offset = 0

        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].bufferIndex = 0
        vertexDescriptor.attributes[1].offset = float4.size

        vertexDescriptor.attributes[2].format = .float2
        vertexDescriptor.attributes[2].bufferIndex = 0
        vertexDescriptor.attributes[2].offset = float3.size + float2.size
        
        vertexDescriptor.layouts[0].stride = EKVertex.stride

        pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm_srgb
        pipelineDescriptor.depthAttachmentPixelFormat = .depth32Float
        pipelineDescriptor.vertexFunction = vertexFunction
        pipelineDescriptor.fragmentFunction = fragmentFunction
        pipelineDescriptor.vertexDescriptor = vertexDescriptor

        depthStencilDescriptor.isDepthWriteEnabled = true
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilState = device.makeDepthStencilState(descriptor: depthStencilDescriptor)

        do {
            pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
        } catch {
            print(error.localizedDescription)
        }
    }

}
