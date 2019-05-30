//
//  AppyButton.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

@IBDesignable
open class AppyButton: UIButton {
    
    // MARK: - Properties
    override open var isHighlighted: Bool {
        didSet {
            #if !TARGET_INTERFACE_BUILDER
                if darkensBackgroundWhenHighlighted {
                    backgroundColor = isHighlighted ? highlightedBackgroundColor : normalBackgroundColor
                }
            #endif
        }
    }
    
    @IBInspectable public var darkensBackgroundWhenHighlighted: Bool = false {
        didSet {
            prepareForUse()
        }
    }
    private var normalBackgroundColor: UIColor!
    private var highlightedBackgroundColor: UIColor!
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.hidesWhenStopped = true
        
        return activityView
    }()
    
    // MARK: - Properties / Border
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
    
    // MARK: - Properties / Corner
    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Properties / Shadow
    @IBInspectable public var shadowColor: UIColor = .clear {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    @IBInspectable public var shadowRadius: CGFloat = 0.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    @IBInspectable public var shadowOpacity: Float = 0.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable public var shadowOffset: CGSize = .zero {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    
    @IBInspectable public var lines: Int = 1 {
        didSet {
            titleLabel?.lineBreakMode = .byWordWrapping
            titleLabel?.numberOfLines = lines
        }
    }
    
    // MARK: - Life Cycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Functions
    public func setShowsActivityIndicator(_ shows: Bool, tintColor: UIColor = .white, interactionEnabled: Bool = false) {
        
        //activityIndicatorView.center = convert(center, from: superview)
        activityIndicatorView.color = tintColor
        addSubview(activityIndicatorView)
        
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        layoutIfNeeded()
        
        if shows {
            isUserInteractionEnabled = interactionEnabled
            activityIndicatorView.startAnimating()
            titleLabel?.removeFromSuperview()
            imageView?.removeFromSuperview()
        }else {
            isUserInteractionEnabled = true
            activityIndicatorView.stopAnimating()
            if let titleLabel = titleLabel {
                addSubview(titleLabel)
            }
            if let imageView = imageView {
                addSubview(imageView)
            }
        }
    }
    
    private func prepareForUse() {
        guard let backgroundColor = backgroundColor else { return }
        
        normalBackgroundColor = backgroundColor
        highlightedBackgroundColor = backgroundColor.darken(by: 10.0)
    }
}
