//
//  RPGGameScene.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 21/12/2020.
//

import SpriteKit

open class RPGGameScene: SKScene, SKPhysicsContactDelegate {
    
    private var backgroundAudio: SKAudioNode?
//    private var collisionHandlers: [String: RPGCollisionHandler] = [:]
    
    public override func sceneDidLoad() {
        physicsWorld.contactDelegate = self
    }
    
    // MARK: - Touches methods
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        RPGGestureDetectorService.shared.touchesBegan(touches, with: event, on: self)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        RPGGestureDetectorService.shared.touchesMoved(touches, with: event, on: self)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        RPGGestureDetectorService.shared.touchesEnded(touches, with: event, on: self)
    }
    
    // MARK: - Collision methods
    
    /// Register a collision handler for this scene
    /// - Parameters:
    ///   - collisionHandler: Collision handler you want to register
    ///   - key: Key of this collision handler
//    func register(collisionHandler: RPGCollisionHandler, withKey key: String) {
//        self.collisionHandlers[key] = collisionHandler
//    }
    
    /// Remove collision handler for this scene
    /// - Parameter key: Key of the collision handler you want to remove
    func removeCollisionHandler(withKey key: String) {
        
//        if let _ = self.collisionHandlers[key] {
//            self.collisionHandlers.removeValue(forKey: key)
//        } else {
//            print("no collision handler with key '\(key)' to remove")
//        }
//
    }
    
    /// Add collision to a tilemap of the game scene
    /// - Parameters:
    ///   - name: Name of the tilemap
    ///   - categoryMask: Category mask of the tilemap so an entity can interact with
    func addCollisionToTilemap(named name: String, withCategoryMask categoryMask: UInt32) {
        
//        if let tilemap = self.childNode(withName: name) as? SKTileMapNode {
//            tilemap.createSweetLinePhysicsBody(categoryMask: categoryMask)
//        }
        
    }
    
    /// Collision did begin between nodes
    public func didBegin(_ contact: SKPhysicsContact) {
//        for collisionHandler in self.collisionHandlers {
//            collisionHandler.value.didBegin(contact)
//        }
    }
    
    /// Collision did end between nodes
    public func didEnd(_ contact: SKPhysicsContact) {
//        for collisionHandler in self.collisionHandlers {
//            collisionHandler.value.didEnd(contact)
//        }
    }
    
    // MARK: - Life cycle methods
    
    open override func update(_ currentTime: TimeInterval) {
        
    }
    
    // MARK: - Portal methods
    
    /// Get all available portals of this scene
    /// - Returns: List of RPGPortal
    func getAvailablePortals() -> [RPGPortal] {
        
        if let portals = self.children.filter({ (child) -> Bool in
            
            if let _ = child as? RPGPortal {
                return true
            } else {
                return false
            }
            
        }) as? [RPGPortal] {
            return portals
        } else {
            return []
        }
        
    }
    
    /// Set portals category mask so that an entity can interact
    /// - Parameter categoryMask: Category mask for all scene's portals
    func setPortalsCategoryMask(categoryMask: UInt32) {
        
        let portals = self.getAvailablePortals()
        
        for portal in portals {
            portal.setCategoryMask(categoryMask: categoryMask)
        }
        
    }
    
    // MARK: - Audio methods
    
    /// Create and play background audio
    /// - Parameter name: Audio file name
    func playBackgroundAudio(fileNamed name: String) {
        
        self.backgroundAudio = SKAudioNode(fileNamed: name)
        
        if let backgroundAudio = self.backgroundAudio {
            
            backgroundAudio.autoplayLooped = true
            
            if let _ = backgroundAudio.parent {} else {
                self.addChild(backgroundAudio)
            }
            
            
            backgroundAudio.run(SKAction.changeVolume(to: 0.5, duration: 0))
            backgroundAudio.run(SKAction.play())
            
        } else {
            print("No audio file named : \(name)")
        }
        
    }
    
    /// Change current background audio volume
    /// - Parameter volume: Volume you want to play audio to
    func setCurrentBackgroundAudioVolume(to volume: Float) {
        
        if let backgroundAudio = self.backgroundAudio {
            backgroundAudio.run(SKAction.changeVolume(to: volume, duration: 0))
        }
        
    }
    
    /// Play current background audio if there is one instanciate
    func playCurrentBackgroundAudio() {
        
        if let backgroundAudio = self.backgroundAudio {
            backgroundAudio.run(SKAction.play())
        }
        
    }
    
    /// Stop current background audio if there is one instanciate
    func stopCurrentBackgroundAudio() {
        
        if let backgroundAudio = self.backgroundAudio {
            backgroundAudio.run(SKAction.stop())
        }
        
    }
    
    /// Remove background audio instance
    func removeBackgroundAudio() {
        
        if let backgroundAudio = self.backgroundAudio {
            
            backgroundAudio.run(SKAction.stop())
            backgroundAudio.removeAllActions()
            backgroundAudio.removeFromParent()
            self.backgroundAudio = nil
            
        }
        
    }
    
}
