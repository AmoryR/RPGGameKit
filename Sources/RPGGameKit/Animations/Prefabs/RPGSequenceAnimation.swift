//
//  RPGSequenceAnimation.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 10/01/2021.
//

import SpriteKit

class RPGSequenceAnimation: RPGAnimation {
    
    init(sequence: [RPGAnimation], withKey key: String) {
        
        var actions = [SKAction]()
        
        for animation in sequence {
            actions.append(animation.action)
        }
        
        super.init(action: SKAction.sequence(actions), withKey: key)
        
    }
    
}
