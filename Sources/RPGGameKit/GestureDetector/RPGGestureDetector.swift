//
//  RPGGestureDetector.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 21/12/2020.
//

import SpriteKit

protocol RPGGestureDetector {
    
    /// Callback when touches began on screen
    /// - Parameter touches: List of touches on screen
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene)
    
    /// Callback when touches moved on screen
    /// - Parameter touches: List of touches on screen
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene)
    
    /// Callback when touches ended on screen
    /// - Parameter touches: List of touches on screen
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene)
}

