//
//  RPGEntityBehavior.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 07/07/2021.
//

public class RPGEntityBehavior {
    
    public var key: String
    internal var entity: RPGEntity?
    
    public init(key: String) {
        self.key = key
    }
    
    public func set(entity: RPGEntity) {
        self.entity = entity
    }
    
    public func update() {}
}
