//
//  EKMesh.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import MetalKit

internal class EKMesh {
    internal var strokeColor: float4 = float4(0, 0, 0, 1)
    internal var fillColor: float4 = float4(1, 0, 0, 1) {
        didSet {
            updateVertices()
        }
    }

    internal var screenSize: CGSize = CGSize.one {
        didSet {
            updateVertices()
        }
    }

    private var size: CGSize
    private var vertices: [EKVertex] = []
    private var vertexBuffer: MTLBuffer?

    internal init(size: CGSize) {
        self.size = size
        setupVertices()
        setupBuffer()
    }

    internal convenience init() {
        self.init(size: CGSize.zero)
    }

    internal func setupVertices() {}

    internal func setupBuffer() {
        vertexBuffer = GPU.device.makeBuffer(bytes: vertices,
                                             length: MemoryLayout<EKVertex>.stride * vertices.count,
                                             options: [])
    }

    internal func addVertex(position: float3,
                            fillColor: float4 = float4(0, 0, 0, 1),
                            textureCoordinate: float2 = float2()) {
        let vertex = EKVertex(position: position, color: fillColor, textureCoordinate: textureCoordinate)
        vertices.append(vertex)
    }

    internal func drawPrimitives(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        renderCommandEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    }

    private func updateVertices() {
        vertices.removeAll()
        setupVertices()
        setupBuffer()
    }

    fileprivate func positionProportion() -> float2 {
        let factor: Float = 1.25
//        var aspectRatio: Float
//        if screenSize.width >= screenSize.height {
//            aspectRatio = (screenSize.height / screenSize.width).asFloat * factor
//        } else {
//            aspectRatio = (screenSize.width / screenSize.height).asFloat * factor
//        }
        let width = (size.width / screenSize.width).asFloat * factor
        let height = (size.height / screenSize.height).asFloat * factor
        let size = float2(width, height)
        return size
    }
}

internal class EKQuadMesh: EKMesh {

    override func setupVertices() {
        let proportion = positionProportion()
        addVertex(position: float3( 1 * proportion.x, 1 * proportion.y, 0), fillColor: fillColor, textureCoordinate: float2(1, 1)) //Top Right
        addVertex(position: float3(-1 * proportion.x, 1 * proportion.y, 0), fillColor: fillColor, textureCoordinate: float2(0, 1)) //Top Left
        addVertex(position: float3(-1 * proportion.x,-1 * proportion.y, 0), fillColor: fillColor, textureCoordinate: float2(0, 0)) //Bottom Left

        addVertex(position: float3( 1 * proportion.x, 1 * proportion.y, 0), fillColor: fillColor, textureCoordinate: float2(1, 1)) //Top Right
        addVertex(position: float3(-1 * proportion.x,-1 * proportion.y, 0), fillColor: fillColor, textureCoordinate: float2(0, 0)) //Bottom Left
        addVertex(position: float3( 1 * proportion.x,-1 * proportion.y, 0), fillColor: fillColor, textureCoordinate: float2(1, 0)) //Bottom Right
    }
}

internal class EKTriangleMesh: EKMesh {
    override func setupVertices() {
        addVertex(position: float3( 0,  1, 0), fillColor: float4(1, 0, 0, 1))
        addVertex(position: float3(-1, -1, 0), fillColor: float4(0, 1, 0, 1))
        addVertex(position: float3( 1, -1, 0), fillColor: float4(0, 0, 1, 1))
    }
}
