//
//  UIService.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 06/04/2021.
//

import SpriteKit

public class RPGUIService {
    
    private var currentScene: RPGGameScene?
    public static let shared = RPGUIService()
    
    private init() {}
    
    public func enableUI(on scene: RPGGameScene) {
        self.currentScene = scene
    }
    
    public func show(element: RPGUIElement) {
        if let currentScene = self.currentScene {
            
            if let camera = currentScene.camera {
                camera.addChild(element)
            } else {
                currentScene.addChild(element)
            }
            
        } else {
            print("Need to enable UI on scene via RPGUIService")
        }
    }
    
    public func hide(element: RPGUIElement) {
        element.removeFromParent()
    }
    
    public func getGameArea() -> CGRect {
        
        if let gameArea = self.currentScene?.getGameArea() {
            return gameArea
        } else {
            print("You need to enable ui on scene before using RPGUIService methods")
            return .null
        }
        
    }
    
}
