//
//  AppyNavigationControllerViewController.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

open class AppyNavigationController: UINavigationController, AppyBaseController {
    
    // MARK: - Properties
    @IBInspectable public var preferedStatusBarStyleIsLight: Bool = false
    @IBInspectable public var clearsBackTitle: Bool = false
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return preferedStatusBarStyleIsLight ? .lightContent : .default
    }
    
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
    }
    
    // MARK: - Functions
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        clearBackTitleIfNeeded()
        super.pushViewController(viewController, animated: animated)
    }
    
    override open func show(_ vc: UIViewController, sender: Any?) {
        clearBackTitleIfNeeded()
        super.show(vc, sender: sender)
    }
    
    open func hasContentToPresent() -> Bool {
        return true
    }
    
    open func userAttamptedToReconnect() {
        loadControllerContent()
        startLoadingContent()
    }
    
    public func loadControllerContent() {
        
    }
    
    private func clearBackTitleIfNeeded() {
        if clearsBackTitle {
            topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}
