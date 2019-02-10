//
//  AppyTableViewCell.swift
//  clapper
//
//  Created by Yusuf Kamil AK on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

open class AppyTableViewCell: UITableViewCell, Identifiable, ReusableCell {
    
    // MARK: - UI Elements
    @IBOutlet weak public var primaryLabel: AppyLabel!
    @IBOutlet weak public var secondaryLabel: AppyLabel!
    @IBOutlet weak public var primaryImageView: AppyImageView!
    
    // MARK: - Variables
    open class var contentHeight: CGFloat {
        return 44.0
    }
    
    open class var contentSize: CGSize {
        return .zero
    }
    
    open var selectedBackgroundColor: UIColor? {
        return nil
    }
    
    // MARK: - Life Cycle
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        if let selectedColor = selectedBackgroundColor {
            let selectedView = UIView()
            selectedView.backgroundColor = selectedColor
            selectedBackgroundView = selectedView
        }
    }
}
