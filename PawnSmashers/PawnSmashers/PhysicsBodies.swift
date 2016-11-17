//
//  PhysicsBodies.swift
//  PawnSmashers
//
//  Created by student on 11/9/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation

struct PhysicsCategory {
    static let None:        UInt32 = 0
    static let ScoreZone:   UInt32 = 0b1 // 1
    static let ScorePawn:   UInt32 = 0b10 // 2
    static let SpeedZone:   UInt32 = 0b100 // 4
    static let Edge:        UInt32 = 0b1000 // 8
    static let Shooter:     UInt32 = 0b10000 // 16
}
