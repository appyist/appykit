//
//  FillableController.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 11.01.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

public protocol FillableController: NavigatableController, Fillable {
    @discardableResult static func push(from fromViewController: AppyController, with object: ObjectType) -> AppyController
    @discardableResult static func present(from fromViewController: AppyController, with object: ObjectType) -> AppyController
}

extension FillableController where Self: AppyController {
    
    @discardableResult public static func push(from fromViewController: AppyController, with object: ObjectType) -> AppyController {
        let destination = destinationViewController()
        destination.fill(with: object)
        fromViewController.navigationController?.pushViewController(destination, animated: true)
        
        return destination
    }
    
    @discardableResult public static func present(from fromViewController: AppyController, with object: ObjectType) -> AppyController {
        let destination = destinationViewController()
        destination.fill(with: object)
        
        if shouldBeEmbededInNavigationControllerBeforeBeingPresented {
            let navController = navigationController(with: destination)
            navController.modalTransitionStyle = destination.modalTransitionStyle
            fromViewController.present(navController, animated: true, completion: nil)
        }else {
            fromViewController.present(destination, animated: true, completion: nil)
        }
        
        return destination
    }
}
