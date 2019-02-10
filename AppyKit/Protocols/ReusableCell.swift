//
//  ReusableCell.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 9.04.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

public protocol ReusableCell { }

extension ReusableCell where Self: AppyTableViewCell {
    static public func dequeReusableCell(withReuseIdentifier customIdentifier: String? = nil, for tableView: UITableView) -> Self {
        let identifier = customIdentifier ?? Self.identifier
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Self {
            return cell
        }
        
        fatalError("TableView cell: \(Self.self) cannot be created with identifier: \(identifier)")
    }
}

extension ReusableCell where Self: AppyTableViewCell & Fillable {
    
    static public func dequeReusableCell(withReuseIdentifier customIdentifier: String? = nil, object: ObjectType, for tableView: UITableView) -> Self {
        let identifier = customIdentifier ?? Self.identifier
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Self {
            cell.fill(with: object)
            
            return cell
        }
        
        fatalError("TableView cell: \(Self.self) cannot be created with identifier: \(identifier)")
    }
    
    
}

extension ReusableCell where Self: AppyCollectionViewCell {
    static public func dequeReusableCell(withReuseIdentifier customIdentifier: String? = nil, for collectionView: UICollectionView, at indexPath: IndexPath) -> Self {
        let identifier = customIdentifier ?? Self.identifier
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Self {
            return cell
        }
        
        fatalError("CollectionView cell: \(Self.self) cannot be created with identifier: \(identifier)")
    }
}
