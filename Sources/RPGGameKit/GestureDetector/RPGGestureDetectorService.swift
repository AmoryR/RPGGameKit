//
//  RPGGestureDetectorService.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 12/03/2021.
//

import SpriteKit

// Feature 1 : Save current state
//          It means I can save all active gesture detectors

// Feature 2 : Retrieve previous state
//          It means active gesture detectors becomes gesture detectors from saved state

// Conflict : With default
// Conflict : Save state -> Remove gesture detector -> retrieve state (missing gesture detector)
//                          Make sure to remove it from state too

class RPGGestureDetectorService {
    
    private var gestureDetectors: [String: RPGGestureDetector] = [:]
    
    private var defaultGestureDetectorKey: String?
    private var activeGestureDetectorKeys = [String]()
    
    static let shared = RPGGestureDetectorService()
    private init() {}
    
    func register(_ gestureDetector: RPGGestureDetector, withKey key: String) {
        self.gestureDetectors[key] = gestureDetector
    }
    
    func removeGestureDetector(withKey key: String) {
        self.gestureDetectors.removeValue(forKey: key)
    }
    
    func setDefaultGestureDetector(key: String) {
        
        if self.gestureDetectors.keys.contains(key) {
            self.defaultGestureDetectorKey = key
        } else {
            print("No gesture detector registered with key '\(key)'")
        }
        
    }
    
    func activateDefault() {
        if let defaultGestureDetectorKey = self.defaultGestureDetectorKey {
            self.desactivateAll()
            self.activateGestureDetector(withKey: defaultGestureDetectorKey)
        } else {
            print("No default gesture detector key registered")
        }
    }
    
    func activateGestureDetector(withKey key: String) {
        if !self.activeGestureDetectorKeys.contains(key) {
            self.activeGestureDetectorKeys.append(key)
        }
    }
    
    func desactivateAll() {
        self.activeGestureDetectorKeys.removeAll()
    }
    
    func saveCurrentState() {}
    func retrieveSavedState() {}
    
    
    /// Callback when touches began on screen
    /// - Parameter touches: List of touches on screen
    func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene) {
        for gestureDetector in self.gestureDetectors {
            if self.activeGestureDetectorKeys.contains(gestureDetector.key) {
                gestureDetector.value.touchesBegan(touches, with: event, on: scene)
            }
        }
    }
    
    /// Callback when touches moved on screen
    /// - Parameter touches: List of touches on screen
    func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene) {
        for gestureDetector in self.gestureDetectors {
            if self.activeGestureDetectorKeys.contains(gestureDetector.key) {
                gestureDetector.value.touchesMoved(touches, with: event, on: scene)
            }
        }
    }
    
    /// Callback when touches ended on screen
    /// - Parameter touches: List of touches on screen
    func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?, on scene: RPGGameScene) {
        for gestureDetector in self.gestureDetectors {
            if self.activeGestureDetectorKeys.contains(gestureDetector.key) {
                gestureDetector.value.touchesEnded(touches, with: event, on: scene)
            }
        }
    }
    
}
