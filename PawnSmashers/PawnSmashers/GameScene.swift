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
    var scoreLabel: SKLabelNode!
    var roundLabel: SKLabelNode!
    var shotCount:Int = 0
    let NUMSHOTS:Int = 2
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
            case .RoundEnd:
                cameraNode.position = CGPoint(x: 1024, y: 750)
                roundOver()
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
    
    func reset(){
        
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
            cameraNode.position = CGPoint(x: 1024, y: 750)
        case .Moving1:
            cameraNode.position = (shootingNode1?.position)!
            checkIfStopped(shooter:(shootingNode1)!)
        case .Moving2:
            cameraNode.position = (shootingNode2?.position)!
            checkIfStopped(shooter:(shootingNode2)!)
        case .RoundEnd:
            cameraNode.position = CGPoint(x: 1024, y: 750)
            
        default:
            cameraNode.position = CGPoint(x: 0,y: 0)
            
        }
        
    }
    
    func calculateShootingVector(currentLocation:CGPoint, previousLocation:CGPoint) -> CGVector {
        return CGVector(dx: -currentLocation.x + previousLocation.x, dy: currentLocation.y - previousLocation.y)
    }
    
    func placeBlock(location:CGPoint) {
        pawnCount += 1
        let node = SKSpriteNode(imageNamed: "white_square")
        node.colorBlendFactor = 0
        node.position = location
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = PhysicsCategory.Shooter
        node.physicsBody?.contactTestBitMask = PhysicsCategory.None
        node.physicsBody?.collisionBitMask = PhysicsCategory.Shooter
        node.zPosition = 10
        addChild(node)
        if( pawnCount > 3) { gameState = GameStates.Shooting2 }
    }
    
    func checkIfStopped(shooter:ShootingNode) {
        shooter.isMoving()
        if shooter.physicsBody!.velocity.dx == CGFloat(0) && shooter.physicsBody!.velocity.dy == CGFloat(0) {
            print("node has stopped")
            
            switch gameState {
            case .Moving1:
                shotCount += 1
                if shotCount < NUMSHOTS
                {
                    gameState = GameStates.Shooting2
                }
                else
                {
                    gameState = GameStates.RoundEnd
                }
            case .Moving2:
                shotCount += 1
                if shotCount < NUMSHOTS{
                    gameState = GameStates.Shooting1
                }
                else
                {
                    gameState = GameStates.RoundEnd
                }
            default:
                print("shiiiiite")
            }
        }
        print(shooter.physicsBody!.velocity)
    }
    
    func roundOver() {
        roundLabel = SKLabelNode(fontNamed: "Futura-CondensedExtraBold")
        roundLabel.fontSize = 150
        roundLabel.zPosition = 12
        roundLabel.text = "Round Over"
        roundLabel.horizontalAlignmentMode = .center
        roundLabel.verticalAlignmentMode = .baseline
        roundLabel.position = CGPoint(x: 1024, y: 1000)
        addChild(roundLabel)
        
        scoreLabel = SKLabelNode(fontNamed: "Futura")
        scoreLabel.fontSize = 80
        roundLabel.zPosition = 11
        scoreLabel.text = "Score: 10,000,000 (no scoring yet)"
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.verticalAlignmentMode = .baseline
        scoreLabel.position = CGPoint(x: 1024, y: 800)
        addChild(scoreLabel)
        
        shootingNode2?.position = CGPoint(x:-1115, y:741)
        shootingNode1?.position = CGPoint(x:3013, y:763)
        gameState = GameStates.Shooting2
    }
}
