//
//  EKDebugCamera.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import Foundation

public class EKDebugCamera: EKCameraNode {

    override public func keyDown(with event: NSEvent) {
        // LEFT
        if event.keyCode == 0x7b {
            position.x -= 0.01
        }
        // RIGHT
        else if event.keyCode == 0x7c {
            position.x += 0.01
        }
        // DOWN
        else if event.keyCode == 0x7d {
            position.y -= 0.01
        }
        // UP
        else if event.keyCode == 0x7e {
            position.y += 0.01
        }
    }

}
