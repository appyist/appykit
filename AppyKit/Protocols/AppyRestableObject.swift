//
//  AppyRestableObject.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 18.11.2017.
//  Copyright © 2017 ilker. All rights reserved.
//

import Foundation

public protocol AppyRestableObject {
    
    // MARK: - Properties
    
    var id: String { get set }
    var createdAt: Date { get set }
    var updatedAt: Date { get set }
    var _isDeleted: Bool { get set }
    
    // MARK: - Functions
    
    func httpPath() -> String
}
