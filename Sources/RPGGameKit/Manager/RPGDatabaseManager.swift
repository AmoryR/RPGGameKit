//
//  RPGGameManager.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 24/03/2021.
//

import SpriteKit

// Find a way to custom this easily
// User should be able to save what he wants from it's custom scene
// Save and load should be defined by subclass
// How to pass object as parameter, Any ?

class RPGDatabaseManager {
    
    static let shared = RPGDatabaseManager()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private init() {}
    
    // Before quitting a scene using scene loader, save current scene and load destination scene
    
    func save(scene: RPGGameScene) {
        
        UserDefaults.standard.setValue("Hello World", forKey: "HelloWorld")
        
//        do {
//            let sceneEncoded = try self.encoder.encode(scene)
//            print("Save scene at : \(scene.name)")
//            UserDefaults.standard.setValue(sceneEncoded, forKey: scene.name)
//        } catch {
//            print("Error encoding scene \(error)")
//        }
        
    }
    
    func load(scene: RPGGameScene) {
        let data = UserDefaults.standard.value(forKey: "HelloWorld")
        if let data = data {
            print("Data: \(data)")
        }
    }
    
    func reset() {
        //https://stackoverflow.com/questions/43402032/how-to-remove-all-userdefaults-data-swift
        // But I want to reset only the values for this game
        UserDefaults.resetStandardUserDefaults() // Don't work
    }
    
    func printDatabase() {
        print("All data: \(UserDefaults.standard.dictionaryRepresentation().keys)")
    }
    
}
