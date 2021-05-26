//
//  RPGAnimation.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 21/12/2020.
//

import SpriteKit

/// NOTE:  Handle sequence and group animation

enum RPGAnimationRepeat {
    case forever
    case once
}

private protocol RPGAnimationProtocol {
    
    var key: String { get set }
    var entity: RPGEntity? { get set }
    
    /// Run this action on RPG entity
    func run()
    
    /// Stop this animation
    func stop()
    
}

class RPGAnimation: RPGAnimationProtocol {
    
    var key: String
    var entity: RPGEntity?
    
    var action: SKAction
    var animationRepeat = RPGAnimationRepeat.once
    
    init(action: SKAction, withKey key: String) {
        self.key = key
        self.action = action
    }
    
    /// Set entity as a target for this animation
    /// - Parameter entity: Assigned entity
    func set(entity: RPGEntity) {
        self.entity = entity
    }
    
    /// Run animation on entity if setted
    func run() {
        if let entity = self.entity {
            switch animationRepeat {
            case .once:
                entity.run(self.action, withKey: self.key)
            case .forever:
                entity.run(SKAction.repeatForever(self.action), withKey: self.key)
            }
        }
    }
    
    /// Stop animation from running
    func stop() {
        if let entity = entity {
            entity.removeAction(forKey: self.key)
        }
    }
    
    /// Repeat this animation forever
    func setRepeatForever() {
        self.animationRepeat = .forever
    }
    
    /// Repeat this animation once
    func setRepeatOnce() {
        self.animationRepeat = .once
    }
    
}

