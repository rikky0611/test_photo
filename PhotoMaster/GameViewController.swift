//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 荒川陸 on 2016/02/25.
//  Copyright © 2016年 riku_arakawa. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var scene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = SKView(frame: CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height))
        view.addSubview(skView)
        
        skView.multipleTouchEnabled = false
        
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
}

