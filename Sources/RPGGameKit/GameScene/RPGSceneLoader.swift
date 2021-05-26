//
//  RPGSceneLoader.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 04/03/2021.
//

import UIKit
import SpriteKit
import GameplayKit

class RPGSceneLoader {
    
    private var mainViewController: UIViewController?
    
    static var shared = RPGSceneLoader()
    
    private init() {}
    
    func set(mainViewController: UIViewController) {
        self.mainViewController = mainViewController
        
        if let view = self.mainViewController?.view as? SKView {
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
    }
    
    func presentScene(named name: String) {
        
        if let mainView = self.mainViewController, let view = mainView.view as? SKView {
            
            // Load scene as a GKScene. This provides gameplay related content
            // including entities and graphs.
            if let scene = GKScene(fileNamed: name) {
                
                // Get the SKScene from the loaded GKScene
                if let sceneNode = scene.rootNode as! RPGGameScene? {
                    
//                    RPGDatabaseManager.shared.load(scene: sceneNode)
                    
                    sceneNode.scaleMode = .aspectFill
                    view.presentScene(sceneNode)
                    
                }
                
            } else {
                fatalError("Can't find a scene named '\(name)'")
            }
            
            
        } else {
            fatalError("You're trying to present a scene on a non existing view controller! Set main view controller property first")
        }
        
    }
    
}
