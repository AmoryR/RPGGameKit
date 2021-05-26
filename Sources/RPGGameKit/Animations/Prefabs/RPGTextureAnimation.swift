//
//  RPGTextureAnimation.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 14/02/2021.
//

import SpriteKit

class RPGTextureAnimation: RPGAnimation {
    
    init(textureName: String, withKey key: String) {
        let texture = SKTexture(imageNamed: textureName)
        texture.filteringMode = .nearest
        super.init(action: SKAction.setTexture(texture), withKey: key)
    }
    
    init(texture: SKTexture, withKey key: String) {
        super.init(action: SKAction.setTexture(texture), withKey: key)
    }
    
}
