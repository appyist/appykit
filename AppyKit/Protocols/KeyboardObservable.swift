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
    public var animationCurve: UIView.AnimationOptions?
    
    // MARK: - Life Cycle
    public init?(userInfo: [AnyHashable : Any]?) {
        guard let info = userInfo else { return nil }
        
        size = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        animationDuration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        animationCurve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? UIView.AnimationOptions
    }
}

@objc public protocol KeyboardObservable {
    func keyboardWillShow(notification: Notification)
    func keyboardWillHide(notification: Notification)
}

extension KeyboardObservable {
    
    public func registerForKeyboardNotifications() {
        let keyboardWillShowKey = UIResponder.keyboardWillShowNotification
        let keyboardWillHideKey = UIResponder.keyboardWillHideNotification
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: keyboardWillShowKey, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: keyboardWillHideKey, object: nil)
    }
}
