//
//  GameViewController.swift
//  Sample
//
//  Created by Ricardo Rachaus on 03/05/19.
//  Copyright © 2019 Ricardo Rachaus. All rights reserved.
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

