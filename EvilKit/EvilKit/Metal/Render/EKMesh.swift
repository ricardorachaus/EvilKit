//
//  EKMesh.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import MetalKit

internal class EKMesh {
    private var vertices: [EKVertex] = []
    private var vertexBuffer: MTLBuffer?

    internal init() {
        setupVertices()
        setupBuffer()
    }

    internal func setupVertices() {}

    internal func setupBuffer() {
        vertexBuffer = GPU.device.makeBuffer(bytes: vertices,
                                             length: MemoryLayout<EKVertex>.stride * vertices.count,
                                             options: [])
    }

    internal func addVertex(position: float3,
                            color: float4 = float4(0, 0, 0, 1),
                            textureCoordinate: float2 = float2()) {
        let vertex = EKVertex(position: position, color: color, textureCoordinate: textureCoordinate)
        vertices.append(vertex)
    }

    internal func drawPrimitives(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }
}

internal class EKQuadMesh: EKMesh {
    override func setupVertices() {
        addVertex(position: float3( 1, 1, 0), color: float4(1, 0, 0, 1), textureCoordinate: float2(1, 1)) //Top Right
        addVertex(position: float3(-1, 1, 0), color: float4(0, 1, 0, 1), textureCoordinate: float2(0, 1)) //Top Left
        addVertex(position: float3(-1,-1, 0), color: float4(0, 0, 1, 1), textureCoordinate: float2(0, 0)) //Bottom Left

        addVertex(position: float3( 1, 1, 0), color: float4(1, 0, 0, 1), textureCoordinate: float2(1, 1)) //Top Right
        addVertex(position: float3(-1,-1, 0), color: float4(0, 0, 1, 1), textureCoordinate: float2(0, 0)) //Bottom Left
        addVertex(position: float3( 1,-1, 0), color: float4(1, 0, 1, 1), textureCoordinate: float2(1, 0)) //Bottom Right
    }
}

internal class EKTriangleMesh: EKMesh {
    override func setupVertices() {
        addVertex(position: float3( 0,  1, 0), color: float4(1, 0, 0, 1))
        addVertex(position: float3(-1, -1, 0), color: float4(0, 1, 0, 1))
        addVertex(position: float3( 1, -1, 0), color: float4(0, 0, 1, 1))
    }
}
