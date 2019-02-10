//
//  UIStoryboardExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 13.01.2018.
//  Copyright © 2018 Appyist. All rights reserved.
//

import Foundation
import UIKit

public extension UIStoryboard {
    
    /// Represents a storyboard type,
    /// This can be extended to add more storyboard types.
    public struct SBType: RawRepresentable, Hashable, Equatable {
        
        // MARK: - RawRepresentable Stubs
        public typealias RawValue = String
        public var rawValue: String
        
        // MARK: - Life Cycle
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
        
        // MARK: - Functions
        public func filename() -> String {
            return rawValue.capitalized
        }
    }
    
    // MARK: - Initializers
    convenience init(type: SBType, bundle: Bundle? = nil) {
        self.init(name: type.filename(), bundle: bundle)
    }
    
    // MARK:- Functions
    func instantiateViewController<T>() -> T where T: AppyController {
        guard let viewController = instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.identifier) ")
        }
        
        return viewController
    }
}

public extension UIStoryboard.SBType {
    
    static let launch = UIStoryboard.SBType(rawValue: "launch")
    static let main = UIStoryboard.SBType(rawValue: "main")
}
