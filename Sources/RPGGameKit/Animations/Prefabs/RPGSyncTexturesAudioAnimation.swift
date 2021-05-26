//
//  RPGSyncTexturesAudioAnimation.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 14/02/2021.
//

import SpriteKit

class RPGSyncTexturesAudioAnimation: RPGAnimation {
    
    // TODO: - Feature : skip some textures for playing sound
    
    /// Create and register audio for you
    init(textures: [SKTexture], timePerFrame time: TimeInterval, audioName: String, audioType: String, audioKey: String, withKey key: String, audioFrameFrequency: Int = 1) {
        super.init(action: SKAction(), withKey: key)
        
        // Here because I can't call self before super initialization
        RPGAudioService.shared.register(audioName: audioName, ofType: audioType, withKey: audioKey)
        self.action = self.getSyncAction(textures: textures, audioKey: audioKey, timePerFrame: time, audioFrameFrequency: audioFrameFrequency)
    }
    
    /// Make sure your audio is register with right key usig RPGAudioService
    init(textures: [SKTexture], timePerFrame time: TimeInterval, audioKey: String, withKey key: String, audioFrameFrequency: Int = 1) {
        super.init(action: SKAction(), withKey: key)
        
        // Here because I can't call self before super initialization
        self.action = self.getSyncAction(textures: textures, audioKey: audioKey, timePerFrame: time, audioFrameFrequency: audioFrameFrequency)
    }
    
    private func getSyncAction(textures: [SKTexture], audioKey: String, timePerFrame time: TimeInterval, audioFrameFrequency: Int) -> SKAction {

        var actions = [SKAction]()

        for (index, texture) in textures.enumerated() {

            let group = self.getAction(forTexture: texture, withAudioKey: audioKey, at: index, audioFrameFrequency: audioFrameFrequency)

            let sequence = SKAction.sequence([group, SKAction.wait(forDuration: time)])
            actions.append(sequence)

        }
        
        return SKAction.sequence(actions)
        
    }
    
    private func getAction(forTexture texture: SKTexture, withAudioKey audioKey: String, at index: Int, audioFrameFrequency: Int) -> SKAction {
        
        if (audioFrameFrequency > 1) {
            
            if (index % audioFrameFrequency == 0) {
                
                return SKAction.setTexture(texture)
                
            } else {
                
                return SKAction.group([
                    SKAction.setTexture(texture),
                    SKAction.run {
                        RPGAudioService.shared.playAudio(withKey: audioKey)
                    }
                ])
                
            }
            
        } else {
            
            return SKAction.group([
                SKAction.setTexture(texture),
                SKAction.run {
                    RPGAudioService.shared.playAudio(withKey: audioKey)
                }
            ])
            
        }
        
    }
    
}
