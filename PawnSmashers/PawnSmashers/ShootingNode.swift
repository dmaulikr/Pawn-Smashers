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
    
    func shoot(shootingVector:CGVector) {
            self.physicsBody?.applyImpulse(shootingVector)
        if ((self.physicsBody?.velocity.dx)! <= CGFloat(200) ) {
            
        self.physicsBody?.velocity.dx = CGFloat(200)
        }
        
        if ((self.physicsBody?.velocity.dy)! <= CGFloat(200)) {
            
        self.physicsBody?.velocity.dy = CGFloat(200)
        }
    }
    
    func calcScore() {
        
    }
}
