//
//  ShiftableController.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 11.01.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

public protocol ShiftableController: NavigatableController, Shiftable {
    @discardableResult static func push(from fromViewController: AppyController, with behavior: BehaviorType, and object: ObjectType?) -> AppyController
    @discardableResult static func present(from fromViewController: AppyController, with behavior: BehaviorType, and object: ObjectType?) -> AppyController
}

public extension ShiftableController where Self: AppyController {
    
    @discardableResult static func push(from fromViewController: AppyController, with behavior: BehaviorType, and object: ObjectType?) -> AppyController {
        let destination = destinationViewController()
        
        destination.shift(to: behavior, with: object)
        fromViewController.navigationController?.pushViewController(destination, animated: true)
        
        return destination
    }
    
    @discardableResult static func present(from fromViewController: AppyController, with behavior: BehaviorType, and object: ObjectType?) -> AppyController {
        let destination = destinationViewController()
        
        destination.shift(to: behavior, with: object)
        
        if shouldBeEmbededInNavigationControllerBeforeBeingPresented {
            let navController = navigationController(with: destination)
            fromViewController.present(navController, animated: true, completion: nil)
        }else {
            fromViewController.present(destination, animated: true, completion: nil)
        }
        
        return destination
    }
}
