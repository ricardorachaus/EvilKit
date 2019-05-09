//
//  EKSpriteNode.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import MetalKit

open class EKSpriteNode: EKNode {

    open var texture: EKTexture?

    public init(named: String) {
        super.init()
        texture = EKTexture(imageNamed: named)
        self.mesh = texture?.mesh
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        super.render(renderCommandEncoder: renderCommandEncoder)
        texture?.render(renderCommandEncoder: renderCommandEncoder)
    }

}
