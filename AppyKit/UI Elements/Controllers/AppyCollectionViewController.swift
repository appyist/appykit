//
//  AppyCollectionViewController.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

open class AppyCollectionViewController: UICollectionViewController, AppyBaseController {
    
    // MARK:- UI Elements
    
    // MARK:- Properties
    open var emptyStateStrings: (title: String, message: String) {
        let title = "Nothing to Display".localized(tableName: "Placeholder")
        let message = "There is no content available to display at this time.".localized(tableName: "Placeholder")
        
        return (title, message)
    }
    
    open var errorStateStrings: (title: String, message: String) {
        let title = "This Feed isn't Available".localized(tableName: "Placeholder")
        let message = "There may be a problem with the server or network.".localized(tableName: "Placeholder")
        
        return (title, message)
    }
    
    // MARK:- Life Cycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        startLoadingContent()
    }
    
    // MARK:- Actions
    
    // MARK:- Functions
    open func hasContentToPresent() -> Bool {
        return true
    }
    
    open func userAttamptedToReconnect() {
        loadControllerContent()
        startLoadingContent()
    }
    
    open func loadControllerContent() {
        
    }
}
