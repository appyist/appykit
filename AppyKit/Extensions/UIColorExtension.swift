//
//  UIColorExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 18.11.2017.
//  Copyright © 2017 ilker. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    // MARK: - Functions
    
    public func lighten(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjust(by: abs(percentage)) ?? self
    }
    
    public func darken(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjust(by: -1 * abs(percentage)) ?? self
    }
    
    private func adjust(by percentage:CGFloat = 30.0) -> UIColor? {
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        if(self.getRed(&r, green: &g, blue: &b, alpha: &a)){
            return UIColor(red: min(r + percentage / 100, 1.0),
                           green: min(g + percentage / 100, 1.0),
                           blue: min(b + percentage / 100, 1.0),
                           alpha: a)
        }else{
            return nil
        }
    }
}
