//
//  BundleExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 18.11.2017.
//  Copyright © 2017 ilker. All rights reserved.
//

import Foundation

public extension Bundle {
    
    // MARK: - Properties
    
    public var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    public var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
