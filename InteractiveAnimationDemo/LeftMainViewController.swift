//
//  ViewController.swift
//  InteractiveAnimationDemo
//
//  Created by chris on 10/22/16.
//  Copyright © 2016 chris. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import CoreMotion


class LeftMainViewController: UIViewController {

    static let storyboardID = "LeftMainViewControllerIdentifier"
    static let updateInterval : Int = 10
    var scene: FloatingScene!

    let motionManager : CMMotionManager = CMMotionManager()
    
    let motionQueue:OperationQueue = {
        var queue = OperationQueue()
        queue.name = "motion_queue"
        queue.maxConcurrentOperationCount = 1
        queue.qualityOfService = QualityOfService.userInitiated // Set to UserInteractive for Highest response, can block UI
        return queue
    }()

    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
     //   if (motionManager.accelerometerData != nil) {
            

            motionManager.startAccelerometerUpdates(to: motionQueue, withHandler: {
                (data:CMAccelerometerData?, error: Error?) in
                
                DispatchQueue.main.async(execute: {
                    NSLog("%@ x= %f , y= %f", "Accel Data: ", Float((data?.acceleration.x)!), Float((data?.acceleration.y)!))

//                    NSLog("Acceleration Data: x= %@ , y= %@", data?.acceleration.x , data?.acceleration.y)

                    if (self.scene != nil) {
                        self.scene.applyUniversalForce(force: CGVector(dx: (Int(10*(data?.acceleration.x)!) * 100), dy: (Int(10*(data?.acceleration.y)!) * 100) ))
                    }
                })
            })
    //    }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
//        if (scene != nil) {
//            scene.size = CGSize(width: size.width-10, height: size.height-10)
//        }
    }
}

