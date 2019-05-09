//
//  GameViewController.swift
//  Sample
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import EvilKit

class GameViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = self.view as! EKView
        let scene = GameScene(size: view.bounds.size)
        view.presentScene(scene)
    }
}

