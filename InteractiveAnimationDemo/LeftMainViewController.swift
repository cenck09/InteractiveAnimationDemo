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

        (self.view as! SKView).presentScene(scene)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        motionManager.startDeviceMotionUpdates(to: motionQueue, withHandler: {
            
            (data:CMDeviceMotion?, error:Error?) in
            
            DispatchQueue.main.async(execute: {
                
                if (self.scene != nil) {
                    self.scene.applyUniversalForce(force: CGVector(dx: (Int(10*((data?.gravity.x)!)) * 2), dy: (Int(10*(data?.gravity.y)!) * 2) ))
                    
                     self.scene.applyUniversalForce(force: CGVector(dx: (Int(10*((data?.userAcceleration.x)!)) * 200), dy: (Int(10*(data?.userAcceleration.y)!) * 200) ))

                    self.scene.applyUniversalForce(force: CGVector(dx: ((data?.rotationRate.y)! * 2), dy: ((data?.rotationRate.x)! * 2)))

                }
            })
        })
    }
    
 
}

