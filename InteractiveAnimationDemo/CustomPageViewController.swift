//
//  CustomPageViewController.swift
//  InteractiveAnimationDemo
//
//  Created by chris on 10/22/16.
//  Copyright © 2016 chris. All rights reserved.
//

import Foundation
import UIKit



class CustomPageViewController: UIPageViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        guard let leftView = storyboard?.instantiateViewController(withIdentifier: LeftMainViewController.storyboardID)
            else { exit(0) }
        
        guard let rightView = storyboard?.instantiateViewController(withIdentifier: RightDetailsViewController.storyboardID)
            else { exit(0) }
        
        setViewControllers([leftView,rightView], direction: .forward, animated: false, completion: {
            (truthiness:Bool) in
            
        })
    }
}
