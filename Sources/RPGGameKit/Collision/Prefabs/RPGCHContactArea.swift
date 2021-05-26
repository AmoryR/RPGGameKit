//
//  RPGCHContactArea.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 25/01/2021.
//

import SpriteKit

// Handle contact between a rpg and contact area (of another rpg)

class RPGCHContactArea: RPGCollisionHandler {
    
    // Make a list ?
    private var entityCategoryMask: UInt32
    private var contactAreaCategoryMask: UInt32
    
    init(entityCategoryMask: UInt32, contactAreaCategoryMask: UInt32) {
        self.entityCategoryMask = entityCategoryMask
        self.contactAreaCategoryMask = contactAreaCategoryMask
    }

    override func didBegin(_ contact: SKPhysicsContact) {
        
        if self.matchingCategoryMask(with: contact, categoryBitMask1: self.entityCategoryMask, categoryBitMask2: self.contactAreaCategoryMask) {
            
            if let entityNode = contact.bodyA.node as? RPGEntity, let contactNode = contact.bodyB.node as? SKSpriteNode {
                
                self.handleContact(entity: entityNode, contactArea: contactNode)
                
            } else if let entityNode = contact.bodyB.node as? RPGEntity, let contactNode = contact.bodyA.node as? SKSpriteNode {
                
                self.handleContact(entity: entityNode, contactArea: contactNode)
                
            } else {
                print("RPGCHContactArea didn't find a RPGEntity and SKSpriteNode from contact bodies")
            }
            
        }
        
    }
    
    override func didEnd(_ contact: SKPhysicsContact) {
        
        if self.matchingCategoryMask(with: contact, categoryBitMask1: self.entityCategoryMask, categoryBitMask2: self.contactAreaCategoryMask) {
            
            if let entityNode = contact.bodyA.node as? RPGEntity{
                
                self.handleContactEnd(entity: entityNode)
                
            } else if let entityNode = contact.bodyB.node as? RPGEntity{
                
                self.handleContactEnd(entity: entityNode)
                
            } else {
                print("RPGCHContactArea didn't find a RPGEntity from contact bodies")
            }
            
        }
        
    }
    
    private func handleContact(entity: RPGEntity, contactArea: SKSpriteNode) {
        
        if let contactAreaParent = contactArea.parent as? RPGEntity {
            entity.contactEntity = contactAreaParent
            entity.feedbackPosition = .top
            entity.showFeedback()
        }
        
    }
    
    private func handleContactEnd(entity: RPGEntity) {
        entity.contactEntity = nil
        entity.hideFeedback()
    }
    
}
