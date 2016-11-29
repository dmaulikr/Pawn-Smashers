//
//  ScoreRing.swift
//  PawnSmashers
//
//  Created by student on 11/15/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation
import SpriteKit
class ScoreRing : SKSpriteNode {
    
    
    func didMoveToScene() {

        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.ScoreZone
        self.physicsBody?.contactTestBitMask = PhysicsCategory.ScorePawn
        self.physicsBody?.collisionBitMask = PhysicsCategory.None    }
    
    
    
}
