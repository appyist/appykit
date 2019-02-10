//
//  AppyAttributedStringBuilder.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 12.04.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

open class AppyAttributedStringBuilder<T> where T: Any {
    
    // MARK: - Types
    //typealias ActionHandler = (CLPBase?) -> Void
    
    // MARK: - Variables
    //var actionHandler: ActionHandler?
    public var object: T?
    public var objects: [T]?
    
    open var defaultColor: UIColor {
        return .lightGray
    }
    
    open var primaryLinkColor: UIColor {
        return  .black
    }
    
    open var secondaryLinkColor: UIColor {
        return .darkGray
    }
    
    open var defaultFont: UIFont {
        return .systemFont(ofSize: fontSize)
    }
    
    open var linkFont: UIFont {
        return UIFont.boldSystemFont(ofSize: fontSize)
    }
    
    open var fontSize: CGFloat {
        return 16.0
    }
    
    public var attributer = Attributer("")
    
    // MARK: - Life Cycle
    public init(with object: T) {
        self.object = object
        //self.actionHandler = actionHandler
    }
    
    public init(with objects: [T]) {
        self.objects = objects
        //self.actionHandler = actionHandler
    }
    
    
    
    // MARK: - Functions
    open func build() -> NSAttributedString {
        guard let language = Locale.primaryLanguageCode() else { return NSAttributedString() }
        
        switch language {
        case "en":
            return buildEnglishString()
        case "tr":
            return buildTurkishString()
        default:
            return NSAttributedString()
        }
    }
    
    /// Should be overriden by subclasses
    open func buildEnglishString() -> NSAttributedString {
        return NSAttributedString()
    }
    
    /// Should be overriden by subclasses
    open func buildTurkishString() -> NSAttributedString {
        return NSAttributedString()
    }
}
