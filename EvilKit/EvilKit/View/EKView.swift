//
//  EKView.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 01/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import MetalKit
import SpriteKit

open class EKView: MTKView {
    
    /**
     The currently presented scene, otherwise nil. If in a transition, the 'incoming' scene is returned.
     */
    open var scene: EKScene? {
        return scenes.first
    }
    
    private var scenes: [EKScene]
    
    init(frame: CGRect) {
        let device = MTLCreateSystemDefaultDevice()
        scenes = []
        super.init(frame: frame, device: device)
    }
    
    public required init(coder: NSCoder) {
        scenes = []
        super.init(coder: coder)
    }
    
    /**
     Present an EKScene in the view, replacing the current scene.
     
     @param scene the scene to present.
     */
    open func presentScene(_ scene: EKScene?) {
        if let scene = scene {
            scenes.insert(scene, at: scenes.startIndex)
        }
    }
    
}
