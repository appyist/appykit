//
//  UIViewControllerExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 29.12.2017.
//  Copyright © 2017 ilker. All rights reserved.
//

import Foundation

private var interactiveNavigationBarHiddenAssociationKey: UInt8 = 0

extension UIApplication {
    override open var next: UIResponder? {
        UIViewController.awake
        return super.next
    }
}

extension UIViewController {
    
    static let awake : Void  = {
        replaceInteractiveMethods()
        return
    }()
    
    @IBInspectable public var interactiveNavigationBarHidden: Bool {
        get {
            var associateValue = objc_getAssociatedObject(self, &interactiveNavigationBarHiddenAssociationKey)
            if associateValue == nil {
                associateValue = false
            }
            return associateValue as! Bool;
        }
        set {
            objc_setAssociatedObject(self, &interactiveNavigationBarHiddenAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    fileprivate static func replaceInteractiveMethods() {
        method_exchangeImplementations(
            class_getInstanceMethod(self, #selector(UIViewController.viewWillAppear(_:)))!,
            class_getInstanceMethod(self, #selector(UIViewController.KD_interactiveViewWillAppear(_:)))!)
    }
    
    @objc func KD_interactiveViewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(interactiveNavigationBarHidden, animated: animated)
    }
}
