//
//  EKNode+Input.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 07/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import Foundation

extension EKNode {

    // MARK: - Keyboard Methods

    open override func keyDown(with event: NSEvent) {
        children.forEach {
            $0.keyDown(with: event)
        }
    }

    open override func keyUp(with event: NSEvent) {
        children.forEach {
            $0.keyUp(with: event)
        }
    }

    // MARK: - Mouse Methods

    open override func mouseUp(with event: NSEvent) {
        children.forEach {
            $0.mouseUp(with: event)
        }
    }

    open override func mouseDown(with event: NSEvent) {
        children.forEach {
            $0.mouseDown(with: event)
        }
    }

    open override func mouseMoved(with event: NSEvent) {
        children.forEach {
            $0.mouseMoved(with: event)
        }
    }

    open override func mouseExited(with event: NSEvent) {
        children.forEach {
            $0.mouseExited(with: event)
        }
    }

    open override func mouseDragged(with event: NSEvent) {
        children.forEach {
            $0.mouseDragged(with: event)
        }
    }

    open override func mouseEntered(with event: NSEvent) {
        children.forEach {
            $0.mouseEntered(with: event)
        }
    }

    // MARK: - Right Mouse Methods

    open override func rightMouseUp(with event: NSEvent) {
        children.forEach {
            $0.rightMouseUp(with: event)
        }
    }


    open override func rightMouseDown(with event: NSEvent) {
        children.forEach {
            $0.rightMouseDown(with: event)
        }
    }

    open override func rightMouseDragged(with event: NSEvent) {
        children.forEach {
            $0.rightMouseDragged(with: event)
        }
    }

    // MARK: - Other Mouse Methods

    open override func otherMouseUp(with event: NSEvent) {
        children.forEach {
            $0.otherMouseUp(with: event)
        }
    }

    open override func otherMouseDown(with event: NSEvent) {
        children.forEach {
            $0.otherMouseDown(with: event)
        }
    }

    open override func otherMouseDragged(with event: NSEvent) {
        children.forEach {
            $0.otherMouseDragged(with: event)
        }
    }

}

