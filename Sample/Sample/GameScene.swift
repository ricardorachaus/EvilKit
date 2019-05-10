//
//  GameScene.swift
//  Sample
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import EvilKit

final class GameScene: EKScene {

    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = .white
        camera = EKDebugCamera()
//        let node = EKSpriteNode(named: "mario.png")
        let node = EKShapeNode(circleOfRadius: 100)
//        node.setScale(0.3)
        addChild(node)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
