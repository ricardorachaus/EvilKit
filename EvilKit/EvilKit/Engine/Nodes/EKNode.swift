//
//  EKNode.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import MetalKit

internal let Z_AXIS: float3 = float3(0, 0, 1)

open class EKNode: NSResponder {

    /**
     The position of the node in the parent's coordinate system
     */
    open var position: CGPoint {
        willSet {
            nodePosition.x = newValue.x.asFloat
            nodePosition.y = newValue.y.asFloat
        }
    }

    /**
     The z-order of the node (used for ordering). Negative z is "into" the screen, Positive z is "out" of the screen. A greater zPosition will sort in front of a lesser zPosition.
     */
    open var zPosition: CGFloat {
        willSet {
            nodePosition.z = newValue.asFloat
        }
    }

    /**
     The Euler rotation about the z axis (in radians)
     */
    open var zRotation: CGFloat {
        willSet {
            nodeRotation.z = newValue.asFloat
        }
    }

    /**
     The scaling in the X axis
     */
    open var xScale: CGFloat {
        willSet {
            nodeScale.x = newValue.asFloat
        }
    }

    /**
     The scaling in the Y axis
     */
    open var yScale: CGFloat {
        willSet {
            nodeScale.y = newValue.asFloat
        }
    }

    /**
     Alpha of this node (multiplied by the output color to give the final result)
     */
    open var alpha: CGFloat

    /**
     The client assignable name.

     In general, this should be unique among peers in the scene graph.
     */
    open var name: String?

    /**
     Physics body attached to the node, with synchronized scale, rotation, and position
     */
    open var physicsBody: EKPhysicsBody? {
        willSet {
            newValue?.node = self
        }
    }

    /**
     The parent of the node.

     If this is nil the node has not been added to another group and is thus the root node of its own graph.
     */
    internal(set) open var parent: EKNode?

    /**
     The children of this node.
     */
    internal(set) open var children: [EKNode]

    /**
     The scene that the node is currently in.
     */
    internal(set) open var scene: EKScene?

    internal var mesh: EKMesh?
    internal var parentMatrix: matrix_float4x4 = matrix_identity_float4x4
    internal var transform: EKNodeTransform
    internal var nodePosition: float3 = float3(0, 0, 0)
    internal var nodeScale: float3 = float3(1, 1, 1)
    internal var nodeRotation: float3 = float3(0, 0, 0)
    internal var nodeMatrix: matrix_float4x4 {
        var matrix = matrix_identity_float4x4
        matrix.translate(direction: nodePosition)
        matrix.rotate(angle: nodeRotation.z, axis: Z_AXIS)
        matrix.scale(axis: nodeScale)
        return matrix_multiply(parentMatrix, matrix)
    }

    // MARK: - Init Methods

    public override init() {
        self.position = CGPoint.zero
        self.zPosition = 0
        self.zRotation = 0
        self.xScale = 1
        self.yScale = 1
        self.alpha = 1
        self.children = []
        self.transform = EKNodeTransform()
        super.init()
    }

    public required init?(coder: NSCoder) {
        self.position = CGPoint.zero
        self.zPosition = 0
        self.zRotation = 0
        self.xScale = 1
        self.yScale = 1
        self.alpha = 1
        self.children = []
        self.transform = EKNodeTransform()
        super.init(coder: coder)
    }

    /**
     Sets both the x & y scale

     @param scale the uniform scale to set.
     */
    open func setScale(_ scale: CGFloat) {
        nodeScale.x = scale.asFloat
        nodeScale.y = scale.asFloat
    }

    // MARK: - Child Methods

    /**
     Adds a node as a child node of this node

     The added node must not have a parent.

     @param node the child node to add.
     */
    open func addChild(_ node: EKNode) {
        children.append(node)
        node.parent = self
    }

    open func insertChild(_ node: EKNode, at index: Int) {
        children.insert(node, at: index)
        node.parent = self
    }

    open func removeChildren(in nodes: [EKNode]) {
        nodes.forEach { node in
            if node.parent == self {
                node.removeFromParent()
            }
        }
    }

    open func removeAllChildren() {
        children.removeAll()
    }

    open func removeFromParent() {
        parent?.children.removeAll { $0 == self }
        parent = nil
    }

    @available(OSX 10.11, *)
    open func move(toParent parent: EKNode) {
        self.parent = parent
    }

    open func childNode(withName name: String) -> EKNode? {
        let node = children.first { child in
            guard let name = child.name else {
                return false
            }
            return name.elementsEqual(name)
        }
        return node
    }

    // MARK: - Render Methods

    internal func updateScreen(size: CGSize) {
        mesh?.screenSize = size
        children.forEach {
            $0.updateScreen(size: size)
        }
    }

    internal func updateNodeMatrix() {
        children.forEach {
            $0.parentMatrix = nodeMatrix
            $0.updateNodeMatrix()
        }
        transform.modelMatrix = nodeMatrix
    }

    internal func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        updateNodeMatrix()
        renderCommandEncoder.setVertexBytes(&transform, length: EKNodeTransform.stride, index: 2)
        children.forEach {
            $0.render(renderCommandEncoder: renderCommandEncoder)
        }
    }

}
