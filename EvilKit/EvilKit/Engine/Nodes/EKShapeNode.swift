//
//  EKShapeNode.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import MetalKit

open class EKShapeNode: EKNode {

    /**
     The color to draw the path with. (for no stroke use [SKColor clearColor]). Defaults to [SKColor whiteColor].
     */
    open var strokeColor: EKColor {
        willSet {
            mesh?.strokeColor = newValue.colorVector()
        }
    }

    /**
     The color to fill the path with. Defaults to [SKColor clearColor] (no fill).
     */
    open var fillColor: EKColor {
        willSet {
            mesh?.fillColor = newValue.colorVector()
        }
    }

    private var size: CGSize = CGSize.zero
    private var material: EKMaterial

    public override init() {
        material = EKMaterial()
        strokeColor = .clear
        fillColor = .clear
        super.init()
    }

    public required init?(coder: NSCoder) {
        material = EKMaterial()
        strokeColor = .clear
        fillColor = .clear
        super.init(coder: coder)
    }

    /* Create a Shape Node representing a rect centered at the Node's origin. */
    @available(OSX 10.10, *)
    public convenience init(rectOf size: CGSize) {
        self.init()
        self.size = size
        self.mesh = EKQuadMesh(size: size)
    }


    /* Create a Shape Node representing an circle centered at the Node's origin. */
    @available(OSX 10.10, *)
    public convenience init(circleOfRadius radius: CGFloat) {
        self.init()
    }

    override internal func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        super.render(renderCommandEncoder: renderCommandEncoder)
        if let mesh = mesh {
            renderCommandEncoder.setFragmentBytes(&material, length: EKMaterial.stride, index: 1)
            mesh.drawPrimitives(renderCommandEncoder: renderCommandEncoder)
        }
    }

}
