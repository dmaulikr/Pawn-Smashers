//
//  ShootingNode.swift
//  PawnSmashers
//
//  Created by student on 11/15/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation
import SpriteKit
class ShootingNode : SKSpriteNode {
    func didMoveToScene() {
        
    }
    
    func shoot() {
        if (self.physicsBody?.velocity.dy <= 40.0) {
            self.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 90))
        }
    
    func calcScore() {
        
    }
}
