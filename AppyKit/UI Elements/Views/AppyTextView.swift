//
//  AppyTextView.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

@IBDesignable
open class AppyTextView: UITextView {
    
    // MARK:- UI Elements
    private let placeholderLabel = UILabel()
    
    // MARK:- Layout Constrainsts
    private var placeholderLabelConstraints = [NSLayoutConstraint]()
    
    // MARK:- Properties / Placeholder
    @IBInspectable public var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    @IBInspectable public var placeholderColor: UIColor = Constants.defaultPlaceholderColor {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    // MARK:- Properties / Border
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    // MARK:- Properties / Corner
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK:- Properties / Container Insets
    @IBInspectable public var topInset: CGFloat = 0.0 {
        didSet {
            textContainerInset = UIEdgeInsets.init(top: topInset, left: textContainerInset.left, bottom: textContainerInset.bottom, right: textContainerInset.right)
        }
    }
    @IBInspectable public var bottomInset: CGFloat = 0 {
        didSet {
            textContainerInset = UIEdgeInsets.init(top: textContainerInset.top, left: textContainerInset.left, bottom: bottomInset, right: textContainerInset.right)
        }
    }
    @IBInspectable public var leftInset: CGFloat = 0 {
        didSet {
            textContainerInset = UIEdgeInsets.init(top: textContainerInset.top, left: leftInset, bottom: textContainerInset.bottom, right: textContainerInset.right)
        }
    }
    @IBInspectable public var rightInset: CGFloat = 0 {
        didSet {
            textContainerInset = UIEdgeInsets.init(top: textContainerInset.top, left: textContainerInset.left, bottom: textContainerInset.bottom, right: rightInset)
        }
    }
    
    override open var font: UIFont! {
        didSet {
            if placeholderFont == nil {
                placeholderLabel.font = font
            }
        }
    }
    public var placeholderFont: UIFont? {
        didSet {
            let font = (placeholderFont != nil) ? placeholderFont : self.font
            placeholderLabel.font = font
        }
    }
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    override open var text: String! {
        didSet {
            textDidChange()
        }
    }
    override open var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }
    override open var textContainerInset: UIEdgeInsets {
        didSet {
            updateConstraintsForPlaceholderLabel()
        }
    }
    
    // MARK:- Life Cycle
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        prepareForUse()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        prepareForUse()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: nil)
    }
    
    // MARK:- Functions
    override open func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.preferredMaxLayoutWidth = textContainer.size.width - textContainer.lineFragmentPadding * 2.0
    }
    
    private func prepareForUse() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
        
        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        placeholderLabel.backgroundColor = UIColor.clear
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(placeholderLabel)
        updateConstraintsForPlaceholderLabel()
    }
    
    private func updateConstraintsForPlaceholderLabel() {
        var newConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(textContainerInset.left + textContainer.lineFragmentPadding))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(textContainerInset.top))-[placeholder]",
            options: [],
            metrics: nil,
            views: ["placeholder": placeholderLabel])
        newConstraints.append(NSLayoutConstraint(
            item: placeholderLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .width,
            multiplier: 1.0,
            constant: -(textContainerInset.left + textContainerInset.right + textContainer.lineFragmentPadding * 2.0)
        ))
        removeConstraints(placeholderLabelConstraints)
        addConstraints(newConstraints)
        placeholderLabelConstraints = newConstraints
    }
    
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}

fileprivate extension AppyTextView {
    
    struct Constants {
        static let defaultPlaceholderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
    }
}
