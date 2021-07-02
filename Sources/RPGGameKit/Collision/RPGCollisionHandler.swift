//
//  RPGCollision.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 07/01/2021.
//

import SpriteKit

private protocol RPGCollisionProtocol {
    
    func didBegin(_ contact: SKPhysicsContact)
    func didEnd(_ contact: SKPhysicsContact)
    
}

public class RPGCollisionHandler: RPGCollisionProtocol {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        print("override did begin for custom behaviors")
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
        print("override did begin for custom behaviors")
    }
    
    // TODO: Add a filter method to know if it should execute didBegin or didEnd
    
    // MARK: Contact handler utils
    
    /// Check if nodeA and nodeB are named by either name1 or name2
    /// - Parameters:
    ///   - nodeA: First node
    ///   - nodeB: Second node
    ///   - name1: First name
    ///   - name2: Second name
    /// - Returns: True if nodeA and nodeB are called by either name1 or name2
    internal func areEsquals(nodeA: SKNode, nodeB: SKNode, name1: String, name2: String) -> Bool {
        return (nodeA.name == name1 && nodeB.name == name2) || (nodeA.name == name2 && nodeB.name == name1)
    }
    
    /// Check if 2 nodes are named the same
    /// - Parameters:
    ///   - nodeA: First node
    ///   - nodeB: Second node
    ///   - name: Name you want to test
    /// - Returns: True if nodeA and nodeB are named 'name'
    internal func areNodesCalled(nodeA: SKNode?, nodeB: SKNode?, name: String) -> Bool {
        
        var isCallA = false
        var isCallB = false
        
        if let nameA = nodeA?.name {
            if nameA == name {
                isCallA = true
            }
        }
        
        if let nameB = nodeB?.name {
            if nameB == name {
                isCallB = true
            }
        }
        
        return isCallA || isCallB
    }
    
    
    /// Know if contact bodies match with category bit mask
    /// - Parameters:
    ///   - contact: Physics contact
    ///   - categoryBitMask1: First category bit mask to test with bodies
    ///   - categoryBitMask2: Second category bit masj to test with bodies
    /// - Returns: True if contact bodies belong to category bit mask 1 and 2
    func matchingCategoryMask(with contact: SKPhysicsContact, categoryBitMask1: UInt32, categoryBitMask2: UInt32) -> Bool {
        
        if (contact.bodyA.categoryBitMask == categoryBitMask1 && contact.bodyB.categoryBitMask == categoryBitMask2) ||
            (contact.bodyA.categoryBitMask == categoryBitMask2 && contact.bodyB.categoryBitMask == categoryBitMask1) {
            return true
        } else {
            return false
        }
        
    }
    
}
