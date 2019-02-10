//
//  NavigatableController.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 11.01.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

public protocol NavigatableController {
    static var storyboardType: UIStoryboard.SBType { get }
    static var modalStyle: UIModalPresentationStyle { get }
    static var modalTransitionStyle: UIModalTransitionStyle { get }
    static var shouldBeEmbededInNavigationControllerBeforeBeingPresented: Bool { get }
    static var shouldHideNavigationBarShadow: Bool { get }
}

extension NavigatableController where Self: AppyController {
    
    public static var modalStyle: UIModalPresentationStyle {
        return .fullScreen
    }
    
    public static var modalTransitionStyle: UIModalTransitionStyle {
        return .coverVertical
    }
    
    public static var shouldBeEmbededInNavigationControllerBeforeBeingPresented: Bool {
        return true
    }
    
    public static var shouldHideNavigationBarShadow: Bool {
        return false
    }

    public static func destinationViewController() -> Self {
        let storyboard = UIStoryboard(name: storyboardType.filename(), bundle: nil)
        return storyboard.instantiateViewController()
    }
    
    public static func navigationController(with rootViewController: AppyController) -> AppyNavigationController {
        let navigationController = AppyNavigationController(rootViewController: rootViewController)
        navigationController.modalPresentationStyle = rootViewController.modalPresentationStyle
        
        let closeItem = UIBarButtonItem(image: #imageLiteral(resourceName: "close_icon"), style: .plain, target: rootViewController, action: #selector(dismissAnimated))
        
        navigationController.clearsBackTitle = true
        
        rootViewController.navigationItem.leftBarButtonItem = closeItem
        (rootViewController as? AppyViewController)?.navigationBarShadowIsHidden = shouldHideNavigationBarShadow
        
        return navigationController
    }
}

fileprivate extension UIViewController {
    
    @objc func dismissAnimated() {
        dismiss(animated: true, completion: nil)
    }
}
