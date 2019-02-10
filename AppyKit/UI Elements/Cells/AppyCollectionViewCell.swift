//
//  AppyCollectionViewCell.swift
//  clapper
//
//  Created by Yusuf Kamil AK on 29/04/2017.
//  Copyright © 2017 ilker. All rights reserved.
//

import UIKit

open class AppyCollectionViewCell: UICollectionViewCell, Identifiable, ReusableCell {
    
    // MARK: - UI Elements
    @IBOutlet weak public var primaryLabel: AppyLabel!
    @IBOutlet weak public var secondaryLabel: AppyLabel!
    @IBOutlet weak public var primaryImageView: AppyImageView!
    
    // MARK: - Variables
    public var cellWidthConstraint: NSLayoutConstraint?
    open class var contentHeight: CGFloat {
        return 44.0
    }
    
    open class var contentSize: CGSize {
        return .zero
    }
    
    open func setCellWidth(_ width: CGFloat) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        cellWidthConstraint = contentView.widthAnchor.constraint(equalToConstant: width)
        cellWidthConstraint?.isActive = true
    }
}
