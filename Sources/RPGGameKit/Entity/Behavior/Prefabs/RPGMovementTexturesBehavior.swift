//
//  RPGMovementTexturesBehavior.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 07/07/2021.
//

import SpriteKit

public class RPGMovementTexturesBehavior: RPGEntityBehavior {
    
    var currentDirection: Direction = .none
    
    private var frontTexture: SKTexture!
    private var leftTexture: SKTexture!
    private var backTexture: SKTexture!
    private var rightTexture: SKTexture!
    
    public init(key: String, textures: [SKTexture]) {
        super.init(key: key)
        
        if (textures.count != 4) {
            fatalError("Textures must contain 4 textures in MovementTexturesBehavior")
        }
        self.frontTexture = textures[0]
        self.leftTexture = textures[1]
        self.backTexture = textures[2]
        self.rightTexture = textures[3]
    }
    
    public override func update() {
        
        if let entity = self.entity {
            let direction = DirectionService.getDirection(forVector: entity.movementDirection)
            
            if direction != self.currentDirection {
                self.currentDirection = direction
                self.changeTexture(for: self.currentDirection)
            }
        }
        
    }
    
    private func changeTexture(for direction: Direction) {
        
        if let entity = self.entity {
            switch direction {
            case .top:
                entity.texture = self.backTexture
                break
            case .bottom:
                entity.texture = self.frontTexture
                break
            case .right:
                entity.texture = self.rightTexture
                break
            case .left:
                entity.texture = self.leftTexture
                break
            default:
                entity.texture = self.frontTexture
            }
        }
        
    }
    
}
