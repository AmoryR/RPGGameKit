//
//  RPGEntity.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 21/12/2020.
//

import SpriteKit

public enum FeedbackPosition {
    case top, right, bottom, left
}

public class RPGEntity: SKSpriteNode {
    
    /// Movement properties
    var movementSpeed: CGFloat = 40.0
    // TODO: Get only property
    var movementDirection: CGVector = .zero
    
    /// Animation property
//    private var animations: [String: RPGAnimation] = [:]
    
    /// Contact area properties
    private var contactAreaRadius: CGFloat = 2.0
    private var contactArea: SKSpriteNode?
    
    /// State properties
    private var currentState: RPGEntityState?
    private var states = [RPGEntityState]()
    
    /// Physics properties
    private var collisionMasksList = [UInt32]()
    private var contactTestsList = [UInt32]()
    
    var contactEntity: RPGEntity?
    var contactPortal: RPGPortal?
    
    // MARK: - Constructors
    
    public init(color: UIColor, size: CGSize) {
        super.init(texture: nil, color: color, size: size)
        
        self.name = "Entity"
    }
    
    public init(textureName: String) {
        super.init(texture: nil, color: .clear, size: .zero)
        
        self.texture = SKTexture(imageNamed: textureName)
        self.texture?.filteringMode = .nearest
        self.size = self.texture!.size()
        
        self.name = "Entity"
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.texture?.filteringMode = .nearest
    }
    
    // MARK: - Contact methods
    
    /// Update contact area radius
    /// - Parameter radius: New radius value
    public func updateContactAreaRadius(for radius: CGFloat) {
        self.contactAreaRadius = radius
        
        if let contactArea = self.contactArea {

            if let categoryMask: UInt32 = contactArea.physicsBody?.categoryBitMask  {
                self.removeContactArea()
                self.addContactArea(categoryMask: categoryMask)
            } else {
                print("No category mask or physics body for contact radius")
            }

        }
        
    }
    
    /// Add contact area around entity to help contact
    /// - Parameter categoryMask: Category mask of the contact area
    public func addContactArea(categoryMask: UInt32) {
        
        self.contactArea = SKSpriteNode()
        
        if let contactArea = self.contactArea {
            
            // TODO: Fix contact area on non-moving entity
            self.physicsBody?.isDynamic = false
            
            contactArea.name = "ContactArea"
            
            contactArea.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width * self.contactAreaRadius)
            contactArea.physicsBody?.affectedByGravity = false
            contactArea.physicsBody?.allowsRotation = false
            contactArea.physicsBody?.isDynamic = false
            
            contactArea.physicsBody?.categoryBitMask = categoryMask
            
            self.addChild(contactArea)
            
            
        } else {
            print("Fail to create contact area")
        }
        
    }
    
    /// Remove contact area
    /// Contact will no longer be available
    public func removeContactArea() {
        
        if let contactArea = self.contactArea {
            contactArea.removeFromParent()
            self.physicsBody?.isDynamic = true
        }
        
    }
    
    /// Main action
    /// Usually called when two entities are in contact
    ///
    /// Maybe be a problem if multiple entities are in contact with each other
    public func mainAction() {
        
        if let contactEntity = self.contactEntity {
            contactEntity.mainAction()
        }
        
        if let portal = self.contactPortal {
            portal.teleport()
        }
        
    }
    
    // MARK: - Feedback methods
    
    private var feedbackTexture: SKTexture?
    private var feedback: SKSpriteNode?
    public var feedbackPosition: FeedbackPosition = .top
    
    public func createFeedback(textureName: String) {
        self.feedbackTexture = SKTexture(imageNamed: textureName)
        self.feedbackTexture!.filteringMode = .nearest
        self.feedback = SKSpriteNode(texture: self.feedbackTexture, size: CGSize(width: 8, height: 8))
    }
    
    public func showFeedback() {
        
        if let feedback = self.feedback {
            
            switch feedbackPosition {
            case .top:
                feedback.position.x = 0
                feedback.position.y = 16
            case .right:
                feedback.position.x = 16
                feedback.position.y = 0
            case .bottom:
                feedback.position.x = 0
                feedback.position.y = -16
            case .left:
                feedback.position.x = -16
                feedback.position.y = 0
            }
            
            // Should I use hidden property ?
            if !self.children.contains(feedback) {
                self.addChild(feedback)
            }
            
        } else {
            print("You need to create a feedback before showing it")
        }
        
    }
    
    public func hideFeedback() {
        
        if let feedback = self.feedback {
            feedback.removeFromParent()
        }
        
    }
    
    // MARK: - Add or remove entity to or from a RPGGameScene
    
    /// Add this entity to a RPGGameScene
    /// - Parameter scene: Scene you want to add this entity on
    public func add(to scene: RPGGameScene) {
        scene.addChild(self)
    }
    
    /// Remove this entity from it's RPGGameScene
    public func remove() {
        self.removeFromParent()
    }
    
    // MARK: - Camera methods
    
    /// Attache a camera
    /// - Parameter camera: Camera you want to attach the player on
    public func attach(camera: RPGCamera) {
        camera.move(toParent: self)
    }
    
    // MARK: - Physics methods
    
    /// Build physics
    /// By default you can't rotate your entity nor affect gravity
    public func buildPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.collisionBitMask = 0b0000_0000
    }
    
    /// Build collision mask bit for physics body from collision masks list
    /// - Returns: Collision mask  bit
    private func buildCollisionMasks() -> UInt32 {
        
        var collisionTestBit: UInt32 = 0x0;
        
        for bit in self.collisionMasksList {
            collisionTestBit += bit
        }
        
        return collisionTestBit
        
    }
    
    /// Build contact test bit for physics body from contact tests list
    /// - Returns: Contact test bit
    private func buildContactTests() -> UInt32 {
        
        var contactTestBit: UInt32 = 0x0;
        
        for bit in self.contactTestsList {
            contactTestBit += bit
        }
        
        return contactTestBit
        
    }
    
    /// Set category mask for physics body properties
    /// - Parameter categoryMask: Category mask of this entity
    public func setCategoryMask(categoryMask: UInt32) {
        
        if let physicsBody = self.physicsBody {
            physicsBody.categoryBitMask = categoryMask
        } else {
            self.buildPhysics()
            self.setCategoryMask(categoryMask: categoryMask)
        }
        
    }
    
    /// Add collision with an other entity
    /// - Parameter collisionMask: Category mask of the entity you want to collide with
    public func addCollisionMask(collisionMask: UInt32) {
        
        if let physicsBody = self.physicsBody {
            if !self.collisionMasksList.contains(collisionMask) {
                self.collisionMasksList.append(collisionMask)
            }
            physicsBody.collisionBitMask = self.buildCollisionMasks()
        } else {
            self.buildPhysics()
            self.addCollisionMask(collisionMask: collisionMask)
        }
        
    }
    
    /// Add contact test with an other entity
    /// - Parameter contactMask: Category mask of the entity you want to test collision and get callback on your collision handler
    public func addContactTest(contactMask: UInt32) {
        
        if let physicsBody = self.physicsBody {
            if !self.contactTestsList.contains(contactMask) {
                self.contactTestsList.append(contactMask)
            }
            physicsBody.contactTestBitMask = self.buildContactTests()
        } else {
            self.buildPhysics()
            self.addContactTest(contactMask: contactMask)
        }
        
    }
    
    // MARK: Entity movement methods
    
    /// Move this entity in a direction
    /// - Parameter direction: Direction you want to move this entity in
    public func move(in direction: CGVector) {
        self.movementDirection = direction.normalized()
    }
    
    /// Stop moving
    public func stopMoving() {
        self.movementDirection = .zero
    }
    
    // MARK: - Animations methods
    
    /// Register a RPGAnimation for this entity
    /// - Parameter animation: Animation to register
//    func register(animation: RPGAnimation) {
//        animation.set(entity: self)
//        animations[animation.key] = animation
//    }
    
    /// Play animation
    /// - Parameter key: Key of the animation you want to play
    func playAnimation(forKey key: String) {
        
//        if !self.isAnimationRunning(withKey: key) {
//            if let animation = animations[key] {
//                animation.run()
//            } else {
//                if key.count != 0 {
//                    print("No animation registered for key : \(key)")
//                }
//            }
//        }
        
    }
    
    /// Stop animation
    /// - Parameter key: Key of the animation you want to stop
    func stopAnimation(forKey key: String) {
//        if let animation = animations[key] {
//            animation.stop()
//        } else {
//            if key.count != 0 {
//                print("No animation registered for key : \(key)")
//            }
//        }
    }
    
    /// Stop all animations
    func stopAllAnimations() {
        self.removeAllActions()
    }
    
    /// Know if an animation is running
    /// - Parameter key: Animation key
    /// - Returns: True if the animation is running
    func isAnimationRunning(withKey key: String) -> Bool {
        
//        if let animation = animations[key] {
//            if let _ = self.action(forKey: animation.key) {
//                return true
//            } else {
//                return false
//            }
//
//        } else {
//            if key.count != 0 {
//                print("No animation registered for key : \(key)")
//            }
            return false
//        }
        
    }
    
    // MARK: - States
    
    /// Create a new state for your entity
    /// - Parameters:
    ///   - key: Use as a reference and make sure it's unique
    ///   - callback: Called when the entity change for this state
    func createState(key: String, callback: @escaping () -> Void) {
        let state = RPGEntityState(key: key, callback: callback)
        self.register(state: state)
    }
    
    /// Register a new state
    /// The callback will not be called
    /// - Parameter state: State to register
    func register(state: RPGEntityState) {
        self.states.append(state)
    }
    
    /// Change state
    /// If the key corresponds to a state, the current state is changed and the callback is called
    /// Otherwise you get an output message
    /// - Parameter key: Reference of your state
    func changeState(withKey key: String) {
        
        let filteredStates = self.states.filter({ (entityState) -> Bool in
            return entityState.key == key
        })
        
        if filteredStates.count == 1 {
            self.currentState = filteredStates[0]
            self.currentState?.callback()
        } else if filteredStates.count > 1 {
            print("There is multiple states for key : \(key)")
        } else {
            print("Can't find state for key : \(key)")
        }
    
    }
    
    // MARK: - Update methods
    
    /// Update entity's velocity
    public func updateVelocity() {
        if let physicsBody = self.physicsBody {
            physicsBody.velocity = self.movementDirection * self.movementSpeed
        }
    }
    
    /// Update entity 
    public func update() {
        self.updateVelocity()
    }
    
}
