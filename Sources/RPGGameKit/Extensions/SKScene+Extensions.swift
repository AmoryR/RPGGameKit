//
//  SKScene+Extensions.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 04/01/2021.
//

import SpriteKit

extension SKScene {
    
    /// Get available game area
    /// https://stackoverflow.com/questions/33707965/how-to-properly-display-a-hud-on-a-spritekit-game-across-different-resolutions
    /// - Returns: Exact screen frame size
    func getGameArea() -> CGRect {
        
        let deviceWidth = UIScreen.main.bounds.width
        let deviceHeight = UIScreen.main.bounds.height
        let maxAspectRatio: CGFloat = deviceWidth / deviceHeight
        
        let playableHeight = size.width / maxAspectRatio
        return CGRect(x: -size.width / 2.0, y: -playableHeight / 2.0, width: size.width, height: playableHeight)
        
    }
    
}
