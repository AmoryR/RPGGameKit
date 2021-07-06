//
//  RPGGDEntity.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 21/12/2020.
//

import SpriteKit

public class RPGGDEntity: RPGGestureDetector {
    
    private var entity: RPGEntity!
    private var camera: RPGCamera?
    private var initialTouchPosition: CGPoint?
    private var movingTouchPosition: CGPoint?
    
    private var initialTouchUI: SKShapeNode?
    private var movingTouchUI: SKShapeNode?
    private var joystickRadius: CGFloat = 20.0
    
    public init(entity: RPGEntity) {
        //super.init()
        
        self.entity = entity
        
        if let camera = self.entity.childNode(withName: "RPGCamera") as? RPGCamera {
            self.camera = camera
        }
        
    }
    
    /// Add ui for entity's gesture detector
    public func addUI() {
        self.initialTouchUI = SKShapeNode(circleOfRadius: 8)
        self.initialTouchUI!.fillColor = .white
        self.initialTouchUI!.alpha = 0.8
        
        self.movingTouchUI = SKShapeNode(circleOfRadius: 7)
        self.movingTouchUI!.glowWidth = 0.5
    }
    
    /// Remove ui for entity's gesture detector
    public func removeUI() {
        self.initialTouchUI = nil
        self.movingTouchUI = nil
    }
    
    /// Handle joystick touches began feedback
    private func joystickTouchesBegan() {
        
        if let initialTouchUI = self.initialTouchUI,
           let movingTouchUI = self.movingTouchUI{
            
            if let initialTouchPosition = self.initialTouchPosition {
                initialTouchUI.position = initialTouchPosition
                movingTouchUI.position = initialTouchPosition
            }
            
            if let _ = initialTouchUI.parent {} else {
                if let camera = self.camera {
                    camera.addChild(initialTouchUI)
                } else {
                    self.entity.addChild(initialTouchUI)
                }
            }
            
            if let _ = movingTouchUI.parent {} else {
                if let camera = self.camera {
                    camera.addChild(movingTouchUI)
                } else {
                    self.entity.addChild(movingTouchUI)
                }
            }
            
        }
        
    }
    
    /// Handle joystick touches moved feedback
    private func joystickTouchesMoved() {
        
        if let initialTouchUI = self.initialTouchUI,
           let movingTouchUI = self.movingTouchUI {
        
            if let initialPosition = self.initialTouchPosition, let movingPosition = self.movingTouchPosition {
                
                let distanceVector = CGVector(
                    dx: initialPosition.x - movingPosition.x,
                    dy: initialPosition.y - movingPosition.y)
                
                if distanceVector.length() < 0.2 {
                    
                    movingTouchUI.position = initialTouchUI.position
                    
                } else if distanceVector.length() > self.joystickRadius {
                    
                    let angle = distanceVector.angle + CGFloat.pi
                    movingTouchUI.position = CGPoint(
                        x: initialPosition.x + self.joystickRadius * cos(angle),
                        y: initialPosition.y + self.joystickRadius * sin(angle))
                    
                } else {
                    movingTouchUI.position = movingPosition
                }
                
            }
            
        }
        
    }
    
    /// Handle joystick touches ended feedback
    private func joystickTouchesEnded() {
        
        if let initialTouchUI = self.initialTouchUI,
           let movingTouchUI = self.movingTouchUI {
            initialTouchUI.removeFromParent()
            movingTouchUI.removeFromParent()
        }
        
    }
    
    /// Get location from entity of camera if there is one attached
    /// - Parameter touch: Touch reference
    /// - Returns: Location in touch
    private func getLocation(for touch: UITouch) -> CGPoint {
        if let camera = self.camera {
            return touch.location(in: camera)
        } else {
            return touch.location(in: self.entity)
        }
    }
    
    /// Callback when touches began on screen
    /// - Parameter touches: List of touches on screen
    public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene) {
        
        if let touch = touches.first {
            
            let touchLocation = self.getLocation(for: touch)
            
            if touchLocation.x > 0 {
                self.entity.mainAction()
            } else {
                self.initialTouchPosition = CGPoint(x: touchLocation.x, y: touchLocation.y)
                self.joystickTouchesBegan()
            }
        }
        
    }
    
    /// Callback when touches moved on screen
    /// - Parameter touches: List of touches on screen
    public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene) {
        
        if let initialTouch = self.initialTouchPosition {
            if let touch = touches.first {
                let touchLocation = self.getLocation(for: touch)
                self.movingTouchPosition = touchLocation
                
                let touchDirection = CGVector(
                    dx: touchLocation.x - initialTouch.x,
                    dy: touchLocation.y - initialTouch.y)
                
                let directionVector = DirectionService.getVector(fromDirection: DirectionService.getDirection(forVector: touchDirection))
                
                self.entity.move(in: directionVector)
                self.joystickTouchesMoved()
            }
        }
        
    }
    
    /// Callback when touches ended on screen
    /// - Parameter touches: List of touches on screen
    public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene) {
        self.initialTouchPosition = nil
        self.entity.stopMoving()
        self.joystickTouchesEnded()
    }
    
}
