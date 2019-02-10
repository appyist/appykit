//
//  AppyViewController.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
open class AppyViewController: UIViewController, AppyBaseController {
    
    // MARK: - UI Elements
    @IBOutlet public weak var tableView: AppyTableView?
    @IBOutlet public weak var collectionView: AppyCollectionView?

    // MARK: - Properties
    @IBInspectable public var navigationBarShadowIsHidden: Bool = false
    @IBInspectable public var navigationBarIsTransparent: Bool = false
    @IBInspectable public var preferedStatusBarHidden: Bool = false
    @IBInspectable public var preferedStatusBarStyleIsLight: Bool = false
    
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
    
    override open var prefersStatusBarHidden: Bool {
        return self.preferedStatusBarHidden
    }
    
    open var shouldObserveKeyboardState: Bool {
        return false
    }
    
    open var placeholderColor: UIColor {
        return .red
    }
    
    // MARK: - Life Cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Adjustments
        setUpInitialViewBehavior()
        
        // Data Adjustments
        startLoadingContent()
        loadControllerContent()
        
        if shouldObserveKeyboardState {
            registerForKeyboardNotifications()
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setShowsShadow(!navigationBarShadowIsHidden)
        setNeedsStatusBarAppearanceUpdate()
        
        if navigationBarIsTransparent {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Actions
    @IBAction public func closeBarButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Functions
    open func keyboardStateChanged(_ shows: Bool, withOptions options: KeyboardOptions) {
        
    }
    
    open func hasContentToPresent() -> Bool {
        return true
    }
    
    open func userAttamptedToReconnect() {
        loadControllerContent()
        startLoadingContent()
    }
    
    open func loadControllerContent() {
        
    }
    
    public func scrollToTop() {
        var contentOffset = CGPoint(x: 0.0, y: -64.0)
        if #available(iOS 11.0, *) {
            contentOffset.y = -view.safeAreaInsets.top
        }
        
        tableView?.setContentOffset(contentOffset, animated: true)
        collectionView?.setContentOffset(contentOffset, animated: true)
    }
}

extension AppyViewController: KeyboardObservable {
    
    public func keyboardWillShow(notification: Notification) {
        if let options = KeyboardOptions(userInfo: notification.userInfo) {
            keyboardStateChanged(true, withOptions: options)
        }
    }
    
    public func keyboardWillHide(notification: Notification) {
        if let options = KeyboardOptions(userInfo: notification.userInfo) {
            keyboardStateChanged(false, withOptions: options)
        }
    }
}
