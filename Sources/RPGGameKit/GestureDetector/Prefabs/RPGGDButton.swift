//
//  RPGGDButton.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 11/03/2021.
//

import SpriteKit

class RPGGDButton: RPGGestureDetector {
    
    private var button: RPGButton
    
    init(button: RPGButton) {
        self.button = button
    }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene) {
        
    }
    
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene) {
        
    }
    
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene) {
        
        if let touch = touches.first {
            self.handle(touch, on: scene)
        }
        
    }
    
    private func handle(_ touch: UITouch, on scene: RPGGameScene) {
        
        let location = touch.location(in: scene)
        
        if let touchedNode = scene.nodes(at: location).first as? RPGButton {
            
            if touchedNode.uuid == self.button.uuid {
                self.button.tapped()
            }
            
        }
        
    }
    
}
