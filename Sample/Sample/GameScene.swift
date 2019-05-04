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
        sprite.position = CGPoint(x: 0, y: 0)
        sprite.xScale = 0.5
        sprite.yScale = 0.5
        sprite.zRotation = 0
        backgroundColor = EKColor.white
        addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
