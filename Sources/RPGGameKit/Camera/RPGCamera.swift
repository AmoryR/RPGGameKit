//
//  RPGCamera.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 21/12/2020.
//

import SpriteKit

class RPGCamera: SKCameraNode {
    
    init(scene: RPGGameScene) {
        super.init()
        self.name = "RPGCamera"
        scene.camera = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
