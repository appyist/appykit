//
//  UITableViewExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 13.04.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

public extension UITableView {
    
    // MARK - Properties
    var tableHeaderBackgroundColor: UIColor? {
        get {
            return value(forKey: "tableHeaderBackgroundColor") as? UIColor
        }
        set {
            setValue(newValue, forKey: "tableHeaderBackgroundColor")
        }
    }
    
    // MARK: - Functions
    func reloadDataWithAnimation(duration: TimeInterval, options: UIViewAnimationOptions = .curveEaseInOut) {
        UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: { self.alpha = 0.0 }, completion: nil)
        self.reloadData()
        UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: { self.alpha = 1.0 }, completion: nil)
    }
}
