//
//  RPGSceneLoader.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 04/03/2021.
//

import UIKit
import SpriteKit
import GameplayKit

public class RPGSceneLoader {
    
    private var mainViewController: UIViewController?
    
    public static var shared = RPGSceneLoader()
    
    private init() {}
    
    public func set(mainViewController: UIViewController) {
        self.mainViewController = mainViewController
        
        if let view = self.mainViewController?.view as? SKView {
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
        }
    }
    
    public func presentScene(named name: String) {
        
        if let mainView = self.mainViewController, let view = mainView.view as? SKView {
            
            if let scene = GKScene(fileNamed: name) {
                
                // Get the SKScene from the loaded GKScene
                if let sceneNode = scene.rootNode as! RPGGameScene? {
                    
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
