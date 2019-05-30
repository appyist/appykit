//
//  AppyLabel.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

@IBDesignable
open class AppyLabel: UILabel {
    
    // MARK: - Properties / Insets
    override open var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
    
    @IBInspectable public var topInset: CGFloat = 0
    @IBInspectable public var rightInset: CGFloat = 0
    @IBInspectable public var bottomInset: CGFloat = 0
    @IBInspectable public var leftInset: CGFloat = 0
    var isTruncated: Bool {
        guard let labelText = text else {
            return false
        }
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil).size
        return labelTextSize.height > bounds.size.height
    }
    
    // MARK: - Properties / Border
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    
    // MARK: - Properties / Corner
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Functions
    override open func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: self.topInset, left: self.leftInset, bottom: self.bottomInset, right: self.rightInset)
        self.setNeedsLayout()
        
        return super.drawText(in: rect.inset(by: insets))
    }
}
