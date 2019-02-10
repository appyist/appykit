//
//  AppyTableView.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

@IBDesignable
open class AppyTableView: UITableView {
    
    // MARK: - Layout Constraints
    var placeholderViewTopConstraint: NSLayoutConstraint?
    var placeholderViewBottomConstraint: NSLayoutConstraint?
    
    // MARK:- Variables
    @IBInspectable public var topInset: CGFloat = 0.0 {
        didSet {
            self.contentInset.top = topInset
        }
    }
    @IBInspectable public var leftInset: CGFloat = 0.0 {
        didSet {
            self.contentInset.left = leftInset
        }
    }
    @IBInspectable public var bottomInset: CGFloat = 0.0 {
        didSet {
            self.contentInset.bottom = bottomInset
        }
    }
    @IBInspectable public var rightInset: CGFloat = 0.0 {
        didSet {
            self.contentInset.right = rightInset
        }
    }
    
    // MARK: - Functions
    public func setShowsEmptyPlaceholder(_ shows: Bool, title: String? = nil, message: String? = nil, disablesInteraction: Bool = true) {
        if shows {
            let container = AppyView()
            let placeholder = EmptyPlaceholderView(frame: .zero, title: title, subtitle: message)
            
            placeholder.background = backgroundColor ?? .white
            
            var topSpacing = contentInset.top
            var bottomSpacing = -contentInset.bottom
            
            if #available(iOS 11.0, *) {
                topSpacing = adjustedContentInset.top
                bottomSpacing = -adjustedContentInset.bottom
            }
            
            topSpacing += tableHeaderView?.bounds.height ?? 0.0
            bottomSpacing -= tableFooterView?.bounds.height ?? 0.0
            
            container.backgroundColor = .clear
            container.addSubview(placeholder)
            
            placeholder.translatesAutoresizingMaskIntoConstraints = false
            
            placeholderViewTopConstraint = placeholder.topAnchor.constraint(equalTo: container.topAnchor, constant: topSpacing)
            placeholderViewTopConstraint?.isActive = true
            
            placeholder.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
            placeholder.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
            
            placeholderViewBottomConstraint = placeholder.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: bottomSpacing)
            placeholderViewBottomConstraint?.isActive = true
            
            backgroundView = container
            
            if disablesInteraction {
                isScrollEnabled = false
            }
        }else {
            backgroundView = nil
            isScrollEnabled = true
        }
    }
    
    open override var contentInset: UIEdgeInsets {
        willSet {
            // If there is tableHeader, then UI glitch will be observed. (IAW: Günah :))
            placeholderViewBottomConstraint?.constant = -newValue.bottom //+ (placeholderViewTopConstraint?.constant ?? 0.0)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: [], animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
