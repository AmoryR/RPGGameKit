//
//  RPGCHContactArea.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 25/01/2021.
//

import SpriteKit

// Handle contact between a rpg and contact area (of another rpg)

public enum FeedbackBody {
    case A, B
}

public class RPGCHContactArea: RPGCollisionHandler {
    
    // Make a list ?
    private var entityCategoryMask: UInt32
    private var contactAreaCategoryMask: UInt32
    
    public var showFeedback = true;
    public var feedbackBody: FeedbackBody = .A
    
    public init(entityCategoryMask: UInt32, contactAreaCategoryMask: UInt32) {
        self.entityCategoryMask = entityCategoryMask
        self.contactAreaCategoryMask = contactAreaCategoryMask
    }

    public override func didBegin(_ contact: SKPhysicsContact) {
        
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
    
    public override func didEnd(_ contact: SKPhysicsContact) {
        
        if self.matchingCategoryMask(with: contact, categoryBitMask1: self.entityCategoryMask, categoryBitMask2: self.contactAreaCategoryMask) {
            
            if let entityNode = contact.bodyA.node as? RPGEntity, let contactNode = contact.bodyB.node as? SKSpriteNode {
                
                self.handleContactEnd(entity: entityNode, contactArea: contactNode)
                
            } else if let entityNode = contact.bodyB.node as? RPGEntity, let contactNode = contact.bodyA.node as? SKSpriteNode {
                
                self.handleContactEnd(entity: entityNode, contactArea: contactNode)
                
            } else {
                print("RPGCHContactArea didn't find a RPGEntity from contact bodies")
            }
            
        }
        
    }
    
    private func handleContact(entity: RPGEntity, contactArea: SKSpriteNode) {
        
        if let otherEntity = contactArea.parent as? RPGEntity {
            entity.contactEntity = otherEntity
            
            if self.showFeedback {
                
                switch self.feedbackBody {
                case .A:
                    entity.showFeedback()
                case .B:
                    otherEntity.showFeedback()
                }
                
            }
        }
        
    }
    
    private func handleContactEnd(entity: RPGEntity, contactArea: SKSpriteNode) {
        entity.contactEntity = nil
        entity.hideFeedback()
        
        if let otherEntity = contactArea.parent as? RPGEntity {
            otherEntity.hideFeedback()
        }
    }
    
}
