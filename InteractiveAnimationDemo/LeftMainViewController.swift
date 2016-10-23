//
//  ViewController.swift
//  InteractiveAnimationDemo
//
//  Created by chris on 10/22/16.
//  Copyright © 2016 chris. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion


class LeftMainViewController: UIViewController, CMMotionManager {

    static let storyboardID = "LeftMainViewControllerIdentifier"

    var scene: FloatingScene!

    let motionManager : CMMotionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scene = FloatingScene(fileNamed:"FloatingScene")
        
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .resizeFill

        skView.presentScene(scene)
    }
    

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
//        if (scene != nil) {
//            scene.size = CGSize(width: size.width-10, height: size.height-10)
//        }
    }
}

