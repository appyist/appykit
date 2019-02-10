//
//  StatableImplementation.swift
//
//
//  Created by Emirhan Erdogan on 28/06/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

public extension StatableController {
    
    // MARK: - Properties
    var viewManager: ViewManager {
        return associatedObject(self, key: &viewManagerKey) { [unowned self] in
            
            let behaviors = [StatableBehavior.empty.rawValue: emptyView,
                             StatableBehavior.loading.rawValue: loadingView,
                             StatableBehavior.error.rawValue: errorView]
            
            return ViewManager(view: self.backingView, behaviors: behaviors)
        }
    }
    
    var currentBehavior: StatableBehavior {
        switch viewManager.currentBehavior {
        case .none: return .content
        case .view(let behavior): return behavior
        }
    }
    
    var lastBehavior: StatableBehavior {
        switch viewManager.lastBehavior {
        case .none: return .content
        case .view(let behavior): return behavior
        }
    }
    
    // MARK: - Custom Views
    var loadingView: UIView {
        let placeholderView = LoadingPlaceholderView(frame: backingView.frame)
        return placeholderView
    }
    
    var errorView: UIView {
        let placeholderView = ErrorPlaceholderView(frame: backingView.frame, title: errorStateStrings.title, subtitle: errorStateStrings.message)
        placeholderView.delegate = self
        
        return placeholderView
    }
    
    var emptyView: UIView {
        let placeholderView = EmptyPlaceholderView(frame: backingView.frame, title: emptyStateStrings.title, subtitle: emptyStateStrings.message)
        return placeholderView
    }
    
    // MARK: - Functions
    func setUpInitialViewBehavior(_ completion: VoidCompletion? = nil) {
        let isLoading = (lastBehavior == .loading)
        let error: NSError? = (lastBehavior == .error) ? NSError(domain: "ist.appy.Statable.ErrorDomain", code: -1, userInfo: nil) : nil
        transitionViewBehaviors(loading: isLoading, error: error, animated: false, completion: completion)
    }
    
    func startLoadingContent(animated: Bool = false, completion: VoidCompletion? = nil) {
        transitionViewBehaviors(loading: true, animated: animated, completion: completion)
    }
    
    func endLoadingContent(animated: Bool = true, error: Error? = nil, completion: VoidCompletion? = nil) {
        transitionViewBehaviors(loading: false, error: error, animated: animated, completion: completion)
    }
    
    func transitionViewBehaviors(loading: Bool = false, error: Error? = nil, animated: Bool = true, completion: VoidCompletion? = nil) {
        // Update view for content (i.e. hide all placeholder views)
        if hasContentToPresent() {
            if let e = error {
                // show unobstrusive error
                handleErrorWhenContentAvailable(e)
            }
            viewManager.transition(to: .none, animated: animated, completion: completion)
            return
        }
        
        // Update view for placeholder
        var newState: StatableBehavior = .empty
        if loading {
            newState = .loading
        } else if let _ = error {
            newState = .error
        }
        viewManager.transition(to: .view(newState), animated: animated, completion: completion)
    }
    
    func hasContentToPresent() -> Bool {
        return true
    }
    
    func handleErrorWhenContentAvailable(_ error: Error) {
        // Default implementation does nothing.
    }
    
    // MARK: - Helpers
    fileprivate func placeholderView(_ behavior: StatableBehavior) -> UIView? {
        return viewManager[behavior]
    }
    
    fileprivate func setPlaceholderView(_ view: UIView?, forBehavior behavior: StatableBehavior) {
        viewManager[behavior] = view
    }
}


// MARK: - Association
private var viewManagerKey: UInt8 = 0
private func associatedObject<T: AnyObject>(_ host: AnyObject, key: UnsafeRawPointer, initial: () -> T) -> T {
    var value = objc_getAssociatedObject(host, key) as? T
    if value == nil {
        value = initial()
        objc_setAssociatedObject(host, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
    return value!
}
