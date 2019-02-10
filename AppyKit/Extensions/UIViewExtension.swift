//
//  UIViewExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 18.11.2017.
//  Copyright © 2017 ilker. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    
    // MARK: - Functions
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    public func generateHapticFeedback(withStyle style: UIImpactFeedbackStyle) {
        if #available(iOS 10.0, *) {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
            feedbackGenerator.impactOccurred()
        }
    }
}
