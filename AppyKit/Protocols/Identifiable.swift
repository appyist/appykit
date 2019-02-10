//
//  Identifiable.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

public protocol Identifiable: class {
    static var identifier: String { get }
}

extension Identifiable where Self: NSObject {
    
    public static var identifier: String {
        return String(describing: self)
    }
}
