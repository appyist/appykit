//
//  Fillable.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

public protocol Fillable {
    associatedtype ObjectType: Any
    
    func fill(with object: ObjectType)
}

public extension Fillable {
    
    func fill(with object: ObjectType) { }
}
