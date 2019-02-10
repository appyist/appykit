//
//  Shiftable.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

public protocol Shiftable: Fillable {
    
    associatedtype BehaviorType: Behavior
    
    func shift(to behavior: BehaviorType)
    func shift(to behavior: BehaviorType, with object: ObjectType?)
}

extension Shiftable {
    
    public func shift(to behavior: BehaviorType) { }
    public func shift(to behavior: BehaviorType, with object: ObjectType?) { }
}
