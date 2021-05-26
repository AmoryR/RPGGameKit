//
//  RPGButton.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 11/03/2021.
//

import SpriteKit

class RPGButton: RPGUIElement {
    
    let uuid = UUID()
    private var callback: () -> () = {}
    
    init(color: UIColor, size: CGSize, callback: @escaping () -> ()) {
        super.init(texture: nil, color: color, size: size)
        
        self.callback = callback
        
        self.createGestureDetector()
    }
    
    init(textureName: String, callback: @escaping () -> ()) {
        super.init(texture: nil, color: .clear, size: .zero)
        
        self.texture = SKTexture(imageNamed: textureName)
        self.texture?.filteringMode = .nearest
        self.size = self.texture!.size()
        
        self.callback = callback
        
        self.createGestureDetector()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createGestureDetector() {
        let gestureDetector = RPGGDButton(button: self)
        RPGGestureDetectorService.shared.register(gestureDetector, withKey: self.uuid.uuidString)
        RPGGestureDetectorService.shared.activateGestureDetector(withKey: self.uuid.uuidString)
    }
    
    func tapped() {
        self.callback()
    }
    
}
