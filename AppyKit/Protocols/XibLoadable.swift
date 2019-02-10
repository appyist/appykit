//
//  XibLoadable.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

/* Loads view that is designed in xib file */
public protocol XibLoadable: BackingViewProvider {
    func loadViewFromXib(frame: CGRect?)
    func viewFromNibClass() -> UIView
}

extension XibLoadable where Self: UIView {
    
    func loadViewFromXib(with nibName: String) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    public func loadViewFromXib(frame: CGRect? = nil) {
        let view = viewFromNibClass()
        view.frame = frame ?? bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    public func viewFromNibClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
}

extension XibLoadable where Self: UIViewController {
    
    func loadViewFromXib() {
        let view = viewFromNibClass()
        view.frame = self.view.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(view)
    }
    
    func viewFromNibClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
}

extension XibLoadable where Self: UITableViewCell {
    
    func loadViewFromXib() {
        let view = viewFromNibClass()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(view)
        contentView.layoutIfNeeded()
    }
}

extension XibLoadable where Self: UICollectionViewCell {
    
    func loadViewFromXib() {
        let view = viewFromNibClass()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(view)
        contentView.layoutIfNeeded()
    }
}
