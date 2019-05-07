//
//  EKView+Input.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import Foundation

extension EKView {

    // MARK: - Keyboard Methods

    open override func keyDown(with event: NSEvent) {
        scene?.keyDown(with: event)
    }

    open override func keyUp(with event: NSEvent) {
        scene?.keyUp(with: event)
    }

    // MARK: - Mouse Methods

    open override func mouseUp(with event: NSEvent) {
        scene?.mouseUp(with: event)
    }

    open override func mouseDown(with event: NSEvent) {
        scene?.mouseDown(with: event)
    }

    open override func mouseMoved(with event: NSEvent) {
       scene?.mouseMoved(with: event)
    }

    open override func mouseExited(with event: NSEvent) {
        scene?.mouseExited(with: event)
    }

    open override func mouseDragged(with event: NSEvent) {
        scene?.mouseDragged(with: event)
    }

    open override func mouseEntered(with event: NSEvent) {
        scene?.mouseEntered(with: event)
    }

    // MARK: - Right Mouse Methods

    open override func rightMouseUp(with event: NSEvent) {
        scene?.rightMouseUp(with: event)
    }

    open override func rightMouseDown(with event: NSEvent) {
        scene?.rightMouseDown(with: event)
    }

    open override func rightMouseDragged(with event: NSEvent) {
        scene?.rightMouseDragged(with: event)
    }

    // MARK: - Other Mouse Methods

    open override func otherMouseUp(with event: NSEvent) {
        scene?.otherMouseUp(with: event)
    }

    open override func otherMouseDown(with event: NSEvent) {
        scene?.otherMouseDown(with: event)
    }

    open override func otherMouseDragged(with event: NSEvent) {
        scene?.otherMouseDragged(with: event)
    }

}

