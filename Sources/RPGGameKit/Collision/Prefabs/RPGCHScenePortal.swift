//
//  RPGCHScenePortal.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 13/01/2021.
//

import SpriteKit

class RPGCHScenePortal: RPGCollisionHandler {
    
    // Make a list ?
    private var entityCategoryMask: UInt32
    private var portalCategoryMask: UInt32
    
    /// Constructor
    /// - Parameter entityCategoryMask: Category mask of the entity you want to test portal collision with
    /// - Parameter portalCategoryMask: Category mask of the portal
    init(entityCategoryMask: UInt32, portalCategoryMask: UInt32) {
        self.entityCategoryMask = entityCategoryMask
        self.portalCategoryMask = portalCategoryMask
    }
    
    override func didBegin(_ contact: SKPhysicsContact) {
        
        if self.matchingCategoryMask(with: contact, categoryBitMask1: self.entityCategoryMask, categoryBitMask2: self.portalCategoryMask) {
            
            if let portalA = contact.bodyA.node as? RPGPortal, let entityA = contact.bodyB.node as? RPGEntity {
                self.contactBegin(between: entityA, and: portalA)
            } else if let portalB = contact.bodyB.node as? RPGPortal, let entityB = contact.bodyA.node as? RPGEntity {
                self.contactBegin(between: entityB, and: portalB)
            } else {
                print("RPGCHScenePortal didn't find a RPGPortal from contact bodies")
            }
            
        }
        
    }
    
    override func didEnd(_ contact: SKPhysicsContact) {
        
        if self.matchingCategoryMask(with: contact, categoryBitMask1: self.entityCategoryMask, categoryBitMask2: self.portalCategoryMask) {
            
            if let portalA = contact.bodyA.node as? RPGPortal, let entityA = contact.bodyB.node as? RPGEntity {
                self.contactEnd(between: entityA, and: portalA)
            } else if let portalB = contact.bodyB.node as? RPGPortal, let entityB = contact.bodyA.node as? RPGEntity {
                self.contactEnd(between: entityB, and: portalB)
            } else {
                print("RPGCHScenePortal didn't find a RPGPortal from contact bodies")
            }
            
        }
        
    }
    
    private func contactBegin(between entity: RPGEntity,and portal: RPGPortal) {
        
        entity.showFeedback()
        entity.contactPortal = portal
        
    }
    
    private func contactEnd(between entity: RPGEntity,and portal: RPGPortal) {
        
        entity.hideFeedback()
        entity.contactPortal = nil
        
    }
    
}
