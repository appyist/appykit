//
//  LocaleExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 6.04.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

public extension Locale {
    
    // MARK: - Functions
    static func primaryLanguageCode() -> String? {
        if let primaryLanguage = Locale.preferredLanguages.first {
            if let languageCode = primaryLanguage.components(separatedBy: "-").first {
                return languageCode
            }
        }
        
        return nil
    }
}
