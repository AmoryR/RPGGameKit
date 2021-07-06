//
//  RPGEntityState.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 14/02/2021.
//

import Foundation

protocol RPGEntityStateProtocol {
    var key: String { get set }
    var callback: () -> Void { get set }
}

class RPGEntityState: RPGEntityStateProtocol {
    
    var key: String
    var callback: () -> Void
    
    init(key: String, callback: @escaping () -> Void) {
        self.key = key
        self.callback = callback
    }
    
}
