//
//  StatablePlaceholderView.swift
//  rana
//
//  Created by Emirhan Erdogan on 28/06/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import Foundation
import UIKit

public protocol StatefulPlaceholderView {
    // Defines the insets to apply when presented via the `StatefulViewController`
    // Return insets here in order to inset the current placeholder view from the edges
    // of the parent view.
    func placeholderViewInsets() -> UIEdgeInsets
}

extension StatefulPlaceholderView {
    
    func placeholderViewInsets() -> UIEdgeInsets {
        return .zero
    }
}

public class StatablePlaceholderView: AppyView, XibLoadable {
    
    // MARK: - UI Elements
    @IBOutlet weak var titleLabel: AppyLabel?
    @IBOutlet weak var subTitleLabel: AppyLabel?
    
    @objc dynamic public var background: UIColor = AppyColor.placeholderGray {
        didSet {
            subviews.first?.backgroundColor = background
        }
    }
    
    // MARK: - Life Cycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromXib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromXib()
    }
    
    convenience public init(frame: CGRect, title: String? = nil, subtitle: String? = nil) {
        self.init(frame: frame)
        
        titleLabel?.isHidden = title == nil
        subTitleLabel?.isHidden = title == nil
        titleLabel?.text = title
        subTitleLabel?.text = subtitle
    }
}
