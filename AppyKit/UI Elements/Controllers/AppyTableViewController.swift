//
//  AppyTableViewController.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

open class AppyTableViewController: UITableViewController, AppyBaseController {
    
	// MARK:- Properties
	@IBInspectable public var navigationBarShadowIsHidden: Bool = false
	@IBInspectable public var navigationBarIsTransparent: Bool = false
	@IBInspectable public var preferedStatusBarHidden: Bool = false
    @IBInspectable public var preferedStatusBarStyleIsLight: Bool = false

    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return preferedStatusBarStyleIsLight ? .lightContent : .default
    }
	override open var prefersStatusBarHidden: Bool {
		return self.preferedStatusBarHidden
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
        
        // UI Adjustments
        setUpInitialViewBehavior()
        
        // Data Adjustments
        startLoadingContent()
        loadControllerContent()
	}
	
	override open func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.navigationBar.setValue(navigationBarShadowIsHidden, forKey: "hidesShadow")
		if navigationBarIsTransparent {
			navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		}
	}
	
	override open func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
    
    // MARK: - Functions
    open func hasContentToPresent() -> Bool {
        return true
    }
    
    open func userAttamptedToReconnect() {
        loadControllerContent()
        startLoadingContent()
    }
    
    open func loadControllerContent() {
        
    }
    
    // MARK:- Actions
    @IBAction func closeBarButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
