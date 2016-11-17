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
        var shootVec = shootingVector
        //shootVec.dy = 0.0;
        shootVec.dx = shootVec.dx * 10
            self.physicsBody?.applyImpulse(shootVec)
        /*
        if ((self.physicsBody?.velocity.dx)! <= CGFloat(200) ) {
            
        self.physicsBody?.velocity.dx = CGFloat(200)
        }
        
        if ((self.physicsBody?.velocity.dy)! <= CGFloat(200)) {
            
        self.physicsBody?.velocity.dy = CGFloat(200)
        }*/
    }
    
    func calcScore() {
        
    }
    
    func isMoving() {
        //if self.physicsBody?.velocity.dx >
    }
}
