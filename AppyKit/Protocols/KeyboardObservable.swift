//
//  KeyboardObservable.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import Foundation
import UIKit

public class KeyboardOptions: NSObject {
    
    // MARK: - Variables
    public var size: CGSize
    public var animationDuration: Double
    public var animationCurve: UIViewAnimationOptions?
    
    // MARK: - Life Cycle
    public init?(userInfo: [AnyHashable : Any]?) {
        guard let info = userInfo else { return nil }
        
        size = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        animationDuration = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
        animationCurve = info[UIKeyboardAnimationCurveUserInfoKey] as? UIViewAnimationOptions
    }
}

@objc public protocol KeyboardObservable {
    func keyboardWillShow(notification: Notification)
    func keyboardWillHide(notification: Notification)
}

extension KeyboardObservable {
    
    public func registerForKeyboardNotifications() {
        let keyboardWillShowKey = Notification.Name.UIKeyboardWillShow
        let keyboardWillHideKey = Notification.Name.UIKeyboardWillHide
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: keyboardWillShowKey, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: keyboardWillHideKey, object: nil)
    }
}
