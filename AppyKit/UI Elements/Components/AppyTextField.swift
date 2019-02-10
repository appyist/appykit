//
//  AppyTextField.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

@IBDesignable
open class AppyTextField: UITextField {
    
    // MARK: - Variables
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    lazy var customClearButton: UIButton = {
        let button = UIButton(type: .custom)
        button.adjustsImageWhenHighlighted = false
        button.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        button.setImage(clearIcon, for: .normal)
        button.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    
    @IBInspectable public var clearIconRightPadding: CGFloat = 0.0
    @IBInspectable public var clearIcon: UIImage? {
        didSet {
            addTarget(self, action: #selector(textChanged), for: .editingChanged)
            rightView = customClearButton
            rightViewMode = .always
        }
    }
    
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightViewRect = super.rightViewRect(forBounds: bounds)
        rightViewRect.origin.x -= clearIconRightPadding
        
        return rightViewRect
    }
    
    open override var text: String? {
        willSet {
            customClearButton.isHidden = newValue?.isEmpty ?? true
        }
    }
    
    @objc func textChanged() {
        customClearButton.isHidden = text!.isEmpty
    }
    
    @IBInspectable public var leftPadding: CGFloat = 0
    @IBInspectable public var rightPadding: CGFloat = 0
    @IBInspectable public var topPadding: CGFloat = 0
    @IBInspectable public var bottomPadding: CGFloat = 0
    
    @IBInspectable public var placeholderColor: UIColor?
    
    // MARK: - Functions
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let placeholderColor = placeholderColor {
            attributedPlaceholder =  NSAttributedString(string: placeholder ?? "",
                                                        attributes: [.foregroundColor: placeholderColor])
        }
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, UIEdgeInsets(top: topPadding, left: leftPadding, bottom: bottomPadding, right: rightPadding))
    }
    
    @objc func clearText() {
        text = ""
    }
    
    deinit {
        removeTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
}
