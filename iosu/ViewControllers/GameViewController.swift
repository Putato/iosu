//
//  GameViewController.swift
//  iosu
//
//  Created by xieyi on 2017/3/28.
//  Copyright © 2017年 xieyi. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    let screenWidth=UIScreen.main.bounds.width*UIScreen.main.scale
    let screenHeight=UIScreen.main.bounds.height*UIScreen.main.scale
    static var sbmode=true
    var alert:UIAlertController!
    let runtestscene=false

    override func viewDidLoad() {
        super.viewDidLoad()
        if runtestscene {
            view?.autoresizesSubviews=true
            let scene=TestScene(size: CGSize(width: screenWidth, height: screenHeight))
            let skView=self.view as! SKView
            skView.showsFPS=true
            skView.showsNodeCount=true
            skView.ignoresSiblingOrder=true
            skView.allowsTransparency=true
            scene.scaleMode = .aspectFit
            scene.backgroundColor = .cyan
            skView.presentScene(scene)
            return
        }
        if GameViewController.sbmode {
            let scene=StoryBoardScene(size: CGSize(width: screenWidth, height: screenHeight),parent:self)
            let skView=self.view as! SKView
            skView.showsFPS=true
            skView.showsNodeCount=true
            skView.showsDrawCount=true
            skView.showsQuadCount=true
            skView.ignoresSiblingOrder=true
            scene.scaleMode = .aspectFit
            skView.presentScene(scene)
        } else {
            let scene=GamePlayScene(size: CGSize(width: screenWidth, height: screenHeight))
            //let skView=self.view as! SKView
            let skView=SKView(frame: UIScreen.main.bounds)
            //For video play
            BGVPlayer.vplayer?.view.layer.zPosition = -1000
            skView.autoresizesSubviews=true
            self.view.autoresizesSubviews=true
            self.view.addSubview((BGVPlayer.vplayer?.view)!)
            skView.layer.zPosition=0
            self.view.addSubview(skView)
            skView.allowsTransparency=true
            skView.backgroundColor = .clear
            (self.view as! SKView).allowsTransparency=true
            
            skView.showsFPS=true
            skView.showsNodeCount=true
            skView.ignoresSiblingOrder=true
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .clear
            skView.presentScene(scene)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        debugPrint("scene appears,\(alert)")
        if alert != nil {
            debugPrint("show alert")
            self.present(alert!, animated: true, completion: nil)
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeLeft
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .landscape
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