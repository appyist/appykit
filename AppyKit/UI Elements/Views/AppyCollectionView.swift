//
//  AppyCollectionView.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

@IBDesignable
open class AppyCollectionView: UICollectionView {

    // MARK:- Properties
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
}
