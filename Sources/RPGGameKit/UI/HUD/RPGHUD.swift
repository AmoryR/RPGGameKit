//
//  RPGHUD.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 11/04/2021.
//

import SpriteKit

enum RPGUIDAnchor {
    case topLeft, topCenter, topRight
    case bottomLeft, bottomCenter, bottomRight
}

class RPGHUD: RPGUIElement {
    
    private var gameArea: CGRect?
    private let paddingHorizontal: CGFloat = 15.0
    private let paddingVertical: CGFloat = 5.0
    
    init(size: CGSize, anchor: RPGUIDAnchor) {
        super.init(texture: nil, color: .clear, size: .zero)
        
        self.gameArea = RPGUIService.shared.getGameArea()
        
        let hudElement = SKSpriteNode(color: .white, size: size)
        hudElement.position = self.getPosition(from: anchor, and: size)
        hudElement.zPosition = 100 // Have a zPosition manager
        self.addChild(hudElement)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getPosition(from anchor: RPGUIDAnchor, and size: CGSize) -> CGPoint {
        
        if let gameArea = self.gameArea {
            
            var position = CGPoint()
            let halfWidth: CGFloat = size.width / 2.0
            let halfHeight: CGFloat = size.height / 2.0
            
            switch anchor {
            case .topLeft:
                position.x = -gameArea.width / 2.0 + halfWidth + paddingHorizontal
                position.y = gameArea.height / 2.0 - halfHeight - paddingVertical
                
            case .topCenter:
                position.y = gameArea.height / 2.0 - halfHeight - paddingVertical
                
            case .topRight:
                position.x = gameArea.width / 2.0 - halfWidth - paddingHorizontal
                position.y = gameArea.height / 2.0 - halfHeight - paddingVertical
                
            case .bottomLeft:
                position.x = -gameArea.width / 2.0 + halfWidth + paddingHorizontal
                position.y = -gameArea.height / 2.0 + halfHeight + paddingVertical
                
            case .bottomCenter:
                position.y = -gameArea.height / 2.0 + halfHeight + paddingVertical
                
            case .bottomRight:
                position.x = gameArea.width / 2.0 - halfWidth - paddingHorizontal
                position.y = -gameArea.height / 2.0 + halfHeight + paddingVertical
                
            }
            
            return position
            
        }
        
        print("No game area found while creating HUD")
        return .zero
    }
    
}
