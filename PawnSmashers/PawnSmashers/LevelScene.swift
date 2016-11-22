//
//  LevelScene.swift
//  PawnSmashers
//
//  Created by Michael Lynch on 11/22/16.
//  Copyright © 2016 Talladega Knights. All rights reserved.
//

import Foundation
import SpriteKit

class LevelScene: SKScene{
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.location(in: self)
        let touchedNode = self.nodes(at: location).first
        
        if let name = touchedNode?.name{
            
            if (name == "Level1"){
                //print("Level 1 pressed")
                loadScene(level: "1")
            } else if (name == "Level2"){
                print("Level 2 pressed")
            } else if (name == "Level3"){
                print("Level 3 pressed")
            } else if (name == "Level4"){
                print("Level 4 pressed")
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        let delta = CGPoint(x: location.x - previousLocation.x, y: location.y - previousLocation.y)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.location(in: self)

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    func loadScene(level: String){
        let fade = SKTransition.fade(withDuration: 2)
        if let newScene = SKScene(fileNamed: "GameScene"){
            scene?.scaleMode = .aspectFill
            scene?.view?.presentScene(newScene, transition: fade)
        }
    }

}
