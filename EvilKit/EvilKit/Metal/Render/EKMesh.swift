//
//  EKMesh.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import MetalKit

internal class EKMesh {
    internal var screenSize: CGSize = CGSize.one {
        didSet {
            updateVertices()
        }
    }

    internal var sizeFactor: Float = 0.0

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
                            textureCoordinate: float2 = float2()) {
        let vertex = EKVertex(position: position, textureCoordinate: textureCoordinate)
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

    internal func positionProportion() -> float2 {
//        var aspectRatio: Float
//        if screenSize.width >= screenSize.height {
//            aspectRatio = (screenSize.height / screenSize.width).asFloat * factor
//        } else {
//            aspectRatio = (screenSize.width / screenSize.height).asFloat * factor
//        }
        let width = (size.width / screenSize.width).asFloat * sizeFactor
        let height = (size.height / screenSize.height).asFloat * sizeFactor
        let size = float2(width, height)
        return size
    }
}

internal class EKQuadMesh: EKMesh {

    override func setupVertices() {
        let proportion = positionProportion()
        addVertex(position: float3( 1 * proportion.x,  1 * proportion.y, 0), textureCoordinate: float2(1, 1)) //Top Right
        addVertex(position: float3(-1 * proportion.x,  1 * proportion.y, 0), textureCoordinate: float2(0, 1)) //Top Left
        addVertex(position: float3(-1 * proportion.x, -1 * proportion.y, 0), textureCoordinate: float2(0, 0)) //Bottom Left

        addVertex(position: float3( 1 * proportion.x,  1 * proportion.y, 0), textureCoordinate: float2(1, 1)) //Top Right
        addVertex(position: float3(-1 * proportion.x, -1 * proportion.y, 0), textureCoordinate: float2(0, 0)) //Bottom Left
        addVertex(position: float3( 1 * proportion.x, -1 * proportion.y, 0), textureCoordinate: float2(1, 0)) //Bottom Right
    }

    override func positionProportion() -> float2 {
        sizeFactor = 1.25
        return super.positionProportion()
    }
}

internal class EKCircularMesh: EKMesh {

    override func setupVertices() {
        let proportion = positionProportion()
        addVertex(position: float3( 1 * proportion.x,  1 * proportion.y, 0), textureCoordinate: float2( 1,  1)) //Top Right
        addVertex(position: float3(-1 * proportion.x,  1 * proportion.y, 0), textureCoordinate: float2(-1,  1)) //Top Left
        addVertex(position: float3(-1 * proportion.x, -1 * proportion.y, 0), textureCoordinate: float2(-1, -1)) //Bottom Left

        addVertex(position: float3( 1 * proportion.x,  1 * proportion.y, 0), textureCoordinate: float2( 1,  1)) //Top Right
        addVertex(position: float3(-1 * proportion.x, -1 * proportion.y, 0), textureCoordinate: float2(-1, -1)) //Bottom Left
        addVertex(position: float3( 1 * proportion.x, -1 * proportion.y, 0), textureCoordinate: float2( 1, -1)) //Bottom Right
    }

    override func positionProportion() -> float2 {
        sizeFactor = 2
        return super.positionProportion()
    }

}
