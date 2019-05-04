//
//  GameScene.swift
//  Sample
//
//  Created by Ricardo Rachaus on 03/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
//

import EvilKit

final class GameScene: EKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        let sprite = EKSpriteNode(imageNamed: "mario.png")
        sprite.position = CGPoint(x: 0.5, y: 0.5)
        sprite.xScale = 1
        sprite.yScale = 1
        sprite.zRotation = 0
        addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
