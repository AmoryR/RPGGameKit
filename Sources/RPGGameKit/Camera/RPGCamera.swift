//
//  RPGCamera.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 21/12/2020.
//

import SpriteKit

public class RPGCamera: SKCameraNode {
    
    public init(scene: RPGGameScene) {
        super.init()
        self.name = "RPGCamera"
        scene.camera = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
