//
//  ErrorPlaceholderView.swift
//  clapper
//
//  Created by Emirhan Erdogan on 01/07/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

public protocol ErrorPlaceholderDelegate: class {
    
    /** Gets called when loading operation failed and user attempted to retry */
    func userAttamptedToReconnect()
}

public class ErrorPlaceholderView: StatablePlaceholderView {
    
    // MARK:- UI Elements
    @IBOutlet weak var button: AppyButton!
    
    // MARK:- Properties
    weak public var delegate: ErrorPlaceholderDelegate?
   
    // MARK:- Actions
    @IBAction func retryButtonTapped(_ sender: AppyButton) {
        delegate?.userAttamptedToReconnect()
    }
}
