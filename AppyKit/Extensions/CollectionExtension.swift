//
//  CollectionExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 4.01.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

public extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
