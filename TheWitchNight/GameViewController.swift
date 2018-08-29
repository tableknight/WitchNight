//
//  GameViewController.swift
//  TheWitchNight
//
//  Created by kai chen on 2018/1/14.
//  Copyright © 2018年 Chen. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let a = UIFont.familyNames
//        for i in a {
////            print(i)
//            let ass = UIFont.fontNames(forFamilyName: i)
//            for s in ass {
//                print(s)
//            }
//        }
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                Data.instance.loadTexture(completion: {
//                    print("123")
//                    setTimeout(delay: 2, completion: {
//                    })
                    view.presentScene(scene)
                    
                })
//                print("here")
            }
            view.backgroundColor = UIColor.black
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
//        print("not in")
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
