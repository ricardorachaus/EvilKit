//
//  EKCameraNode.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 03/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import simd

open class EKCameraNode: EKNode {
    
    internal var viewMatrix: matrix_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        viewMatrix.translate(direction: -nodePosition)
        return viewMatrix
    }
    
    internal var projectionMatrix: matrix_float4x4 {
        return matrix_identity_float4x4
    }
    
    /**Checks if the node is contained inside the viewport of the camera.
     * The camera and node must both be in the same scene and presented on a view in order
     * to determine if the node is inside the camera viewport rectangle.
     *
     * @return YES if the node is inside the viewport. NO if node is nil or the node is outside the viewport.
     */
    open func contains(_ node: EKNode) -> Bool {
        return false
    }
    
    
    /**Returns the set of nodes in the same scene as the camera that are contained within its viewport.
     * @return the set of nodes contained
     */
    open func containedNodeSet() -> Set<EKNode> {
        return Set<EKNode>()
    }
}
