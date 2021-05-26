//
//  RPGGroupAnimation.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 10/01/2021.
//

import SpriteKit

class RPGGroupAnimation: RPGAnimation {
    
    init(group: [RPGAnimation], withKey key: String) {
        
        var actions = [SKAction]()
        
        for animation in group {
            actions.append(animation.action)
        }
        
        super.init(action: SKAction.group(actions), withKey: key)
        
    }
    
}
