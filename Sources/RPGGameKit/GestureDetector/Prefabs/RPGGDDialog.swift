//
//  GDDialog.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 07/03/2021.
//

import SpriteKit

class RPGGDDialog: RPGGestureDetector {
    
    private var dialog: RPGDialog
    
    init(dialog: RPGDialog) {
        self.dialog = dialog
    }
    
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene) {
        
        if let touch = touches.first {
            self.handle(touch, on: scene)
        }
        
    }
    
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene) {
        
    }
    
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene) {
        
    }
    
    private func handle(_ touch: UITouch, on scene: RPGGameScene) {
        
        let location = touch.location(in: scene)
        
        // Don't work very well when there is a label
        let nodes = scene.nodes(at: location).filter({
            if let _ = $0 as? RPGDialog {
                return true
            } else {
                return false
            }
        })
        
        if let touchedDialog = nodes.first as? RPGDialog {
            if touchedDialog.uuid == self.dialog.uuid {
                self.dialog.tapped()
            }
        }
        
    }
    
}
