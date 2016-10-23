//
//  FloatingScene.swift
//  InteractiveAnimationDemo
//
//  Created by chris on 10/22/16.
//  Copyright © 2016 chris. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit

class FloatingScene: SKScene {
    
    static let orbCount : Int = 10
    static let maxLife : UInt32 = 30
    static let minLife : UInt32 = 5
    
    static let maxSize : UInt32 = 20
    static let minSize : UInt32 = 20

    static let fadeSpeed : Int = 5
    
    let orbArray : NSMutableArray = {
        var arr = NSMutableArray()
        return arr
    }()
    
    open func applyUniversalForce(force:CGVector){
        for i : Int in 0...orbArray.count-1 {
            (orbArray[i] as! SKSpriteNode).physicsBody?.applyForce(force)
        }
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        NSLog("%@", "Body Did Move")
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)

        borderBody.friction = 0

        self.physicsBody = borderBody
        
        for _ in 0...FloatingScene.orbCount {

            let deadlineTime = DispatchTime.now() + .seconds(Int(arc4random_uniform(4)))
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.spawnSprite(sprite: SKSpriteNode(imageNamed: "ball-o"))
            }
        }
    }
 
    func configureSprite(sprite:SKSpriteNode){
        sprite.alpha = 0.0
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.frame.size.width/2)
        sprite.physicsBody?.isDynamic = true
        sprite.physicsBody?.friction = 0.0
        sprite.physicsBody?.density = 20
        sprite.physicsBody?.linearDamping = 0.1
    }
    
    func moveBody(sprite:SKSpriteNode, lifeSpan:Int){
        
        let randX: Int = {
            var n = Int(arc4random_uniform(2)) + 1
            if arc4random_uniform(2) == 1 {
                n *= -1
            }
            return n
        }()
        
        let randY: Int = {
            var n = Int(arc4random_uniform(2)) + 1
            if arc4random_uniform(2) == 1 {
                n *= -1
            }
            return n
        }()
        
        
        sprite.physicsBody?.applyImpulse(CGVector(dx: randX, dy: randY))
        
        let deadlineTime = DispatchTime.now() + .milliseconds(Int(arc4random_uniform(1000)))
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            if lifeSpan <= 0 {
               
                self.killSprite(sprite: sprite)

            }else{
                self.moveBody(sprite: sprite, lifeSpan: (lifeSpan - 1) )
            }
        }
    }
    
    
    func killSprite(sprite:SKSpriteNode){

        let hideAction : SKAction = SKAction.fadeOut(withDuration: TimeInterval(FloatingScene.fadeSpeed))
        let removeAction : SKAction = SKAction.customAction(withDuration: TimeInterval(0.0), actionBlock: {
            (node:SKNode, val:CGFloat) in
            self.orbArray.remove(node)
            node.removeFromParent();
            self.spawnSprite(sprite: SKSpriteNode(imageNamed: "ball-o"))
        })
    
        
        let actionSequence :SKAction = SKAction.sequence([hideAction, removeAction])
        sprite.run(actionSequence)

    }
    
    func spawnSprite(sprite:SKSpriteNode){
        
        let fy: Int = {
            var n = Int(arc4random_uniform(UInt32(self.frame.height/2)))
            if arc4random_uniform(2) == 1 {
                n *= -1
            }
            return n
        }()
        
        let fx: Int = {
            var n = Int(arc4random_uniform(UInt32(self.frame.width/2)))
            if arc4random_uniform(2) == 1 {
                n *= -1
            }
            return n
        }()

        let randSize : Int = Int(arc4random_uniform(FloatingScene.maxSize)+FloatingScene.minSize)
        
        sprite.position = CGPoint(x: fx, y: fy)
        sprite.size = CGSize(width: randSize, height: randSize)

        self.addChild(sprite)
        
        self.configureSprite(sprite: sprite)
        self.orbArray.add(sprite)
        
        let lifeSpan: Int =  Int(arc4random_uniform(FloatingScene.maxLife)+FloatingScene.minLife)
        

        moveBody(sprite: sprite, lifeSpan: lifeSpan);
        
        let showAction : SKAction = SKAction.fadeIn(withDuration: TimeInterval(FloatingScene.fadeSpeed))
        sprite.run(showAction)
    }
    
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
    }
    
    override func didChangeSize(_ oldSize: CGSize) {

        NSLog("%@", "Body Did change size")
       
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody

    }
}
