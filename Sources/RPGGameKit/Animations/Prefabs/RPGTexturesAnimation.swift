//
//  RPGTexturesAnimation.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 02/01/2021.
//

import SpriteKit

class RPGTexturesAnimation: RPGAnimation {
    
    init(textures: [SKTexture], timePerFrame time: TimeInterval, withKey key: String) {
        let action = SKAction.animate(with: textures, timePerFrame: time)
        super.init(action: action, withKey: key)
    }
    
}
