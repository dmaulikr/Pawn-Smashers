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
    var shootingVector:CGVector?
    let cameraNode = SKCameraNode()
    var pawnCount:Int = 0
    var gameState = GameStates.Setup2 {
        didSet {
            print("gameState changed")
            switch gameState {
            case .Shooting1:
                //cameraNode.position = (shootingNode1?.position)!
                cameraNode.position = CGPoint(x: 2306, y: 724)
            case .Shooting2:
                //cameraNode.position = (shootingNode2?.position)!
                cameraNode.position = CGPoint(x: -350, y: 724)
            case .Setup1,
                 .Setup2:
                cameraNode.position = CGPoint(x: 1024, y: 750)
            case .Moving1:
                cameraNode.position = (shootingNode2?.position)!
            case .Moving2:
                cameraNode.position = (shootingNode1?.position)!
            default:
                cameraNode.position = CGPoint(x: 0,y: 0)

            }
        }
    }
    
    override func didMove(to view: SKView) {
        addChild(cameraNode)
        camera = cameraNode
        //cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
        //cameraNode.position = CGPoint(x: 2306, y: 724)
        cameraNode.position = CGPoint(x: -350, y: 724)
        shootingNode1 = childNode(withName: "shooter1") as? ShootingNode
        shootingNode2 = childNode(withName: "shooter2") as? ShootingNode
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //shootingNode1?.shoot(shootingVector:CGVector(dx: -90, dy: 0))
        //print("impulse on shooter1")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        let delta = CGPoint(x: location.x - previousLocation.x, y: location.y - previousLocation.y)
        shootingVector = calculateShootingVector(currentLocation: location, previousLocation: previousLocation)
        //shootingNode2?.shoot(shootingVector: calculateShootingVector(currentLocation: location, previousLocation: previousLocation))
        //cameraNode.position = CGPoint(x: cameraNode.position.x + delta.x, y: cameraNode.position.y + delta.y)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //gameState = GameStates.Shooting2
        let touch = touches.first! as UITouch
        let location = touch.location(in: self)
        
        
        switch gameState {
        case .Shooting1:
            shootingNode1?.shoot(shootingVector: shootingVector!)
            print("impulse applied to shooter1")
            gameState = GameStates.Moving1
        case .Shooting2:
            shootingNode2?.shoot(shootingVector: shootingVector!)
            print("impulse applied to shooter2")
            gameState = GameStates.Moving2
        case .Setup1,
             .Setup2:
            placeBlock(location:location)
            print("in setup1 or setup2")
        case .Moving1,
             .Moving2:
            //checkIfStopped()
            print("something is bad m'kay")
        default:
            print("something is wrong")
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        switch gameState {
        case .Shooting1:
            //cameraNode.position = (shootingNode1?.position)!
            cameraNode.position = CGPoint(x: 2306, y: 724)
        case .Shooting2:
            //cameraNode.position = (shootingNode2?.position)!
            cameraNode.position = CGPoint(x: -350, y: 724)
        case .Setup1,
             .Setup2:
            cameraNode.position = CGPoint(x: 1024,y: 750)
        case .Moving1:
            cameraNode.position = (shootingNode1?.position)!
            checkIfStopped(shooter:(shootingNode1)!)
        case .Moving2:
            cameraNode.position = (shootingNode2?.position)!
            checkIfStopped(shooter:(shootingNode2)!)
        default:
            cameraNode.position = CGPoint(x: 0,y: 0)
            
        }
        
    }
    
    func calculateShootingVector(currentLocation:CGPoint, previousLocation:CGPoint) -> CGVector {
        return CGVector(dx: -currentLocation.x + previousLocation.x, dy: currentLocation.y - previousLocation.y)
    }
    
    func placeBlock(location:CGPoint) {
        pawnCount += 1
        var node = SKSpriteNode(imageNamed: "white_square")
        node.colorBlendFactor = 0
        node.position = location
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = true // 2
        node.physicsBody?.categoryBitMask = PhysicsCategory.ScorePawn
        node.physicsBody?.contactTestBitMask = PhysicsCategory.None
        node.physicsBody?.collisionBitMask = PhysicsCategory.None
        node.zPosition = 10
        addChild(node)
        if( pawnCount > 3) { gameState = GameStates.Shooting2 }
    }
    
    func checkIfStopped(shooter:ShootingNode) {
        if shooter.physicsBody!.velocity.dx == CGFloat(0) && shooter.physicsBody!.velocity.dy == CGFloat(0) {
            print("node has stopped")
            
            switch gameState {
            case .Moving1:
                gameState = GameStates.Shooting2
            case .Moving2:
                gameState = GameStates.Shooting1
            default:
                print("shiiiiite")
            }
        }
    }
}
