//
//  BackingControllerProvider.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 11.01.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import UIKit

public protocol BackingControllerProvider {
    var backingController: UIViewController { get }
}

extension BackingControllerProvider where Self: UIViewController {
    
    public var backingController: UIViewController {
        return self
    }
}

extension BackingControllerProvider where Self: UITableViewController {
    
    public var backingController: UIViewController {
        return self
    }
}
