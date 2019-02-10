//
//  UINavigationBarExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 30.01.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

public extension UINavigationBar {
    
    func setShowsShadow(_ shows: Bool) {
        setValue(!shows, forKey: "hidesShadow")
    }
}
