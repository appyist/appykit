//
//  Localizable.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 12.07.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

protocol Localizable {
    
    // MARK: - Properties
    var tableName: String { get }
}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
}

extension Localizable where Self: UIViewController {
    var tableName: String {
        let controllerName = String(describing: Self.self)
        
        if let range = controllerName.range(of: "TableViewController") ?? controllerName.range(of: "ViewController") {
            return String(controllerName.prefix(upTo: range.lowerBound))
        }
        
        return ""
    }
    
    func localize(string: String) -> String {
        return string.localized(tableName: tableName)
    }
}
