//
//  BackingViewProvider.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

public protocol BackingViewProvider {
    var backingView: UIView { get }
}

extension BackingViewProvider where Self: UIViewController {
    
    public var backingView: UIView {
        return view
    }
}

extension BackingViewProvider where Self: UITableViewController {
    
    public var backingView: UIView {
        return view
    }
}

extension BackingViewProvider where Self: UICollectionViewController {
    
    public var backingView: UIView {
        return view
    }
}

extension BackingViewProvider where Self: UIView {
    
    public var backingView: UIView {
        return self
    }
}

extension BackingViewProvider where Self: UITableViewCell {
    
    public var backingView: UIView {
        return self.contentView
    }
}

extension BackingViewProvider where Self: UICollectionViewCell {
    
    public var backingView: UIView {
        return self.contentView
    }
}
