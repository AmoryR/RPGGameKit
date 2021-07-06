//
//  SKTextureAtlas.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 03/01/2021.
//

import SpriteKit

extension SKTextureAtlas {
    
    /// Get all the textures from atlas images
    /// - Returns: List of textures from atlas images
    func getTextures() -> [SKTexture] {
        var textures: [SKTexture] = []
        
        for i in 0..<self.textureNames.count {
            
            if let textureName = self.textureNames.filter( { (name) -> Bool in
                return name.contains(String(i + 1))
            }).first {
                let texture = self.textureNamed(textureName)
                texture.filteringMode = .nearest
                textures.append(texture)
            }
           
        }
        
        return textures
    }
    
}
