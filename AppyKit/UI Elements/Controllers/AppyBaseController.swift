//
//  AppyController.swift
//  AppyKit
//
//  Created by Appyist on 18.11.2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

public typealias AppyController = AppyBaseController & UIViewController

public protocol AppyBaseController: Identifiable, BackingControllerProvider, StatableController {
    
    /** Incoming segue identifier for storyboards. */
    static var segueIdentifier: String { get }
    
    /** Tells that internet is now available */
    func internetConnectionBecameUnavaible()
    
    /** Tells that internet is no longer available */
    func internetConnectionBecameAvaible()
    
    /** Called by viewDidLoad everytime and once it's been overriden */
    func loadControllerContent()
}

extension AppyBaseController where Self: UIViewController {
    
    // MARK: - Properties
    public static var segueIdentifier: String {
        let controllerName = String(describing: self)
        
        if let range = controllerName.range(of: "TableViewController") ?? controllerName.range(of: "ViewController") {
            return "to" + controllerName.prefix(upTo: range.lowerBound)
        }else {
            fatalError("\(controllerName) does not follow ViewController naming convention for generating segue identifier.")
        }
    }
    
    /** Responsible from tracking internet connection  */
    private var reachability: Reachability {
        return associatedObject(self, key: &reachabilityKey, initial: { () -> Reachability in
            return Reachability()!
        })
    }
    
    // MARK: - Functions
    public func setShowsActivityIndicatorOnStatusBar(_ shows: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = shows
    }
    
    public func internetConnectionBecameUnavaible() { }
    public func internetConnectionBecameAvaible() { }
    
    private func setUpReachability() {
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                self.internetConnectionBecameAvaible()
            }
        }
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self.internetConnectionBecameUnavaible()
            }
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}

// Association Keys
fileprivate var reachabilityKey: UInt8 = 1
fileprivate var statusBarAlertPresenterKey: UInt8 = 2

// Association Function
fileprivate func associatedObject<T: AnyObject>(_ host: AnyObject, key: UnsafeRawPointer, initial: () -> T) -> T {
    var value = objc_getAssociatedObject(host, key) as? T
    if value == nil {
        value = initial()
        objc_setAssociatedObject(host, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
    return value!
}
