//
//  CGSizeExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 6.02.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

public extension CGSize {
    
    // Functions
    static func square(width: CGFloat) -> CGSize {
        return CGSize(width: width, height: width)
    }
}
