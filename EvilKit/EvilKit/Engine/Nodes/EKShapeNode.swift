//
//  EKShapeNode.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import MetalKit

open class EKShapeNode: EKNode {

    private var mesh: EKMesh

    public override init() {
        mesh = EKQuadMesh()
        super.init()
    }

    public required init?(coder: NSCoder) {
        mesh = EKMesh()
        super.init(coder: coder)
    }

    override internal func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        mesh.drawPrimitives(renderCommandEncoder: renderCommandEncoder)
        super.render(renderCommandEncoder: renderCommandEncoder)
    }

}
