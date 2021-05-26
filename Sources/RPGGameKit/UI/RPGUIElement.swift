//
//  RPGUIElement.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 06/04/2021.
//

import SpriteKit

class RPGUIElement: SKSpriteNode {
    
    func show() {
        RPGUIService.shared.show(element: self)
    }
    
    func hide() {
        RPGUIService.shared.hide(element: self)
        RPGGestureDetectorService.shared.activateDefault()
        // Retrieve state ?
    }
    
}
