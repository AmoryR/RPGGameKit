//
//  RPGSceneNavigationPortal.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 13/01/2021.
//

import SpriteKit

// 1. Create a SpriteKit with custom class RPGSceneNavigationPortal
// 2. Set physics
// 3. Set user data (type and scene)
// 4. Get a reference and set category mask (choose default one) use setPortalCategoryMask(...)
// 5. Add contact test to entity

// 5. Use collision handler prefab to handle this
// 6. Register it to game scene

// Create a RPGCollisionHandler prefab for this

enum RPGPortalType {
    case entrance
    case exit
    case error
}

// Find a way to set a position on the other scene
// For now player appears at (0,0)

class RPGPortal: SKSpriteNode {
    
    // TODO: Get only !
    var type: RPGPortalType = .error
    
    // TODO: Get only !
    var sceneName: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.color = .clear

        // 1. Get type (entrance or exit)
        
        guard let type = self.userData?.value(forKey: "type") as? String else {
            fatalError("Portal (\(String(describing: self.name))) shoud have a type (entrance or exit) defined in UserData")
        }

        switch type {
        case "entrance":
            self.type = .entrance
            break
        case "exit":
            self.type = .exit
            break
        default:
            fatalError("Type '\(type)' doesn't exist in RPGPortalType for RPGSceneNavigationPortal")
        }
            
        
        // 2. Get destination or source
        guard let sceneName = self.userData?.value(forKey: "scene") as? String else {
            fatalError("Portal (\(String(describing: self.name))) shoud have a scene defined in UserData")
        }
        
        self.sceneName = sceneName
        
        // 3. Set name
        self.name = "ScenePortal"
        
    }
    
    /// Set category mask for physics body properties
    /// - Parameter categoryMask: Category mask of this entity
    func setCategoryMask(categoryMask: UInt32) {
        
        if let physicsBody = self.physicsBody {
            physicsBody.categoryBitMask = categoryMask
        } else {
            print("You must set physics body from scene editor before setting category bit mask for scene portal.")
        }
        
    }
    
    func teleport() {
      
        switch self.type {
        case .entrance:
            
            if let sceneName = self.sceneName {
                RPGSceneLoader.shared.presentScene(named: sceneName)
            } else {
                print("No scene name for portal")
            }
            
            break
        default:
            print("You can only teleport with entrance portal")
            break
        }
        
    }
    
}
