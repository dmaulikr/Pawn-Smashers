//
//  GameScene.swift
//  PawnSmashers
//
//  Created by student on 11/9/16.
//  Copyright © 2016 student. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var shootingNode1:ShootingNode?
    private var shootingNode2:ShootingNode?
    let cameraNode = SKCameraNode()
    var gameState = GameStates.Shooting1 {
        didSet {
            switch gameState {
            case .Shooting1:
                cameraNode.position = (shootingNode1?.position)!
            case .Shooting2:
                cameraNode.position = (shootingNode1?.position)!
            case .Setup1,
                 .Setup2:
                cameraNode.position = (shootingNode1?.position)!
            default:
                cameraNode.position = CGPoint(x: 0,y: 0)

            }
        }
    }
    
    override func didMove(to view: SKView) {
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
        shootingNode1 = childNode(withName: "shooter1") as? ShootingNode
        shootingNode2 = childNode(withName: "shooter2") as? ShootingNode
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        gameState = GameStates.Shooting2
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.location(in: self.view)
        self.camera?.position = location
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
   
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}
