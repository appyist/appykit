//
//  AppyAlertAction.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 2.04.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

// MARK: - Equatable Stubs
public func == (lhs: AppyAlertAction , rhs: AppyAlertAction) -> Bool {
    return lhs.title == rhs.title
}

public struct AppyAlertAction: Hashable, Equatable {
    
    // MARK: - Properties
    public var title: String
    public var style: UIAlertActionStyle
    
    // MARK: - Life Cycle
    public init(title: String, style: UIAlertActionStyle = .default) {
        self.title = title
        self.style = style
    }
}

public extension AppyAlertAction {
    
    static let okay = AppyAlertAction(title: "OK".localized(tableName: "AlertAction"))
    static let done = AppyAlertAction(title: "Done".localized(tableName: "AlertAction"))
    
    static let cancel = AppyAlertAction(title: "Cancel".localized(tableName: "AlertAction"), style: .cancel)
    static let delete = AppyAlertAction(title: "Delete".localized(tableName: "AlertAction"), style: .destructive)
    static let remove = AppyAlertAction(title: "Remove".localized(tableName: "AlertAction"), style: .destructive)
    static let report = AppyAlertAction(title: "Report".localized(tableName: "AlertAction"), style: .destructive)
}
