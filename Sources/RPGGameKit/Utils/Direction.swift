//
//  Direction.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 13/02/2021.
//

import CoreGraphics

enum Direction {
    case top
    case right
    case bottom
    case left
    case none
}

class DirectionService {
    
    /// Get direction from an angle
    /// - Parameter angle: Angle value between -PI and PI
    /// - Returns: The direction closest to the angle
    static func getDirection(forAngle angle: CGFloat) -> Direction {
        
        let pi_25 = CGFloat.pi * 0.25
        let pi_75 = CGFloat.pi * 0.75
        
        if angle.isInRange(min: pi_25, max: pi_75, equal: false) {
            return .top
        } else if angle.isInRange(min: -pi_25, max: pi_25) {
            return .right
        } else if angle.isInRange(min: -pi_75, max: -pi_25, equal: false) {
            return .bottom
        } else {
            return .left
        }
        
    }
    
    /// Get dierction from vector
    /// - Parameter vector: Vector value as CGVector
    /// - Returns: The direction of the vector using the angle
    static func getDirection(forVector vector: CGVector) -> Direction {
        return DirectionService.getDirection(forAngle: vector.angle)
    }
    
    
    /// Get vector from a direction
    /// - Parameter direction: Direction you want to get the vector of
    /// - Returns: Vector corresponding to a direction
    static func getVector(fromDirection direction: Direction) -> CGVector {
        
        switch direction {
        case .top:
            return CGVector(dx: 0.0, dy: 1.0)
        case .right:
            return CGVector(dx: 1.0, dy: 0.0)
        case .bottom:
            return CGVector(dx: 0.0, dy: -1.0)
        case .left:
            return CGVector(dx: -1.0, dy: 0.0)
        case .none:
            return .zero
        }
        
    }
    
}
