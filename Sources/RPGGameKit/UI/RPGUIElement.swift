//
//  RPGUIElement.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 06/04/2021.
//

import SpriteKit

public class RPGUIElement: SKSpriteNode {
    
    public func show() {
        RPGUIService.shared.show(element: self)
    }
    
    public func hide() {
        RPGUIService.shared.hide(element: self)
        RPGGestureDetectorService.shared.activateDefault()
    }
    
}
