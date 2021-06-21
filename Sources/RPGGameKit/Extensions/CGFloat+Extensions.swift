//
//  CGFloat+Extensions.swift
//  RPGGameKit
//
//  Created by Amory Rouault on 14/02/2021.
//

import CoreGraphics

public extension CGFloat {
    
    /// Know if this float  value is in a range of values
    /// - Parameters:
    ///   - min: Min value of the range
    ///   - max: Max value of the range
    ///   - equal: Boolean that defines if you want the value to be equal to the range values
    /// - Returns: True if this value is in the range
    func isInRange(min: CGFloat, max: CGFloat, equal: Bool = true) -> Bool {
        return equal ? self <= max && self >= min : self < max && self > min
    }
    
}
