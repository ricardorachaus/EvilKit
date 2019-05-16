//
//  EKPhysicsContactDelegate.swift
//  EvilKit
//
//  Created by Ricardo Rachaus on 10/05/19.
//  Copyright © 2019 rachaus. All rights reserved.
//

import Foundation

public protocol EKPhysicsContactDelegate : NSObjectProtocol {
    func didBegin(_ contact: EKPhysicsContact)
    func didEnd(_ contact: EKPhysicsContact)
}

public extension EKPhysicsContactDelegate {
    func didBegin(_ contact: EKPhysicsContact) {}
    func didEnd(_ contact: EKPhysicsContact) {}
}
