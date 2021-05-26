//
//  RPGAudioService.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 05/01/2021.
//

import SpriteKit
import AVFoundation

class RPGAudioService {
    
    /// Singleton propertie
    static var shared: RPGAudioService = {
        var audioService = RPGAudioService()
        return audioService
    }()
    
    private var audios: [String: AVAudioPlayer] = [:]
    
    /*
        TODO: Try using SpriteKit for audio
            private var audios: [String: SKAudioNode] = [:]
            audioNode = SKAudioNode(fileNamed: "...")
            audioNode.run(SKAction.play())
     */
    
    private init() {}
    
    /// Register an audio to play it later
    /// - Parameters:
    ///   - name: Name of the audio file
    ///   - type: Type of the audio file
    ///   - key: Registration key
    func register(audioName name: String, ofType type: String, withKey key: String) {
        
        if let pathToSound = Bundle.main.path(forResource: name, ofType: type) {
            let url = URL(fileURLWithPath: pathToSound)
            
            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: url)
                self.audios[key] = audioPlayer
            } catch {
                print(error)
            }
        } else {
            print("Can't find path for file : \(name).\(type)")
        }
        
    }
    
    /// Remove audio
    /// - Parameter key: Registration key
    func removeAudio(withKey key: String) {

        if let _ = self.audios[key] {
            self.audios.removeValue(forKey: key)
        } else {
            print("Can't play audio for key : \(key)")
        }
        
    }
    
    /// Play audio
    /// - Parameter key: registration key
    func playAudio(withKey key: String) {
        
        if let audio = self.audios[key] {
            audio.play()
        } else {
            print("Can't play audio for key : \(key)")
        }
        
    }
    
}
