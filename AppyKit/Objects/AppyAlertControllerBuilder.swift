//
//  AppyAlertControllerBuilder.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 15.01.2018.
//  Copyright © 2018 Appyist. All rights reserved.
//

import Foundation
import UIKit

public class AppyAlertControllerBuilder {
    
    // MARK: UI Elements
    lazy var alertController: UIAlertController = {
        return UIAlertController(title: self.title, message: self.message, preferredStyle: self.style)
    }()
    
    // MARK: - Properties
    public var title: String?
    public var message: String?
    public var actions: [AppyAlertAction]!
    public var style: UIAlertController.Style!
    var textField: UITextField? {
        return alertController.textFields?[safe: 0]
    }
    
    // MARK: - Life Cycle
    public init(title: String? = nil, message: String? = nil, actions: [AppyAlertAction], style: UIAlertController.Style) {
        self.title = title
        self.message = message
        self.actions = actions
        self.style = style
    }
    
    public convenience init(style: UIAlertController.Style) {
        self.init(actions: [.done], style: style)
    }
    
    // MARK: - Functions
    public func embedTextField(placeholder: String? = nil, text: String? = nil) {
        alertController.addTextField { (textField) in
            textField.text = text
            textField.placeholder = placeholder
        }
    }
    
    public func present(in controller: UIViewController, completion: ((_ receivedAction: AppyAlertAction, _ inputText: String?) -> Void)?) {
        self.actions.forEach { (current) in
            let actionTitle = current.title
            let actionStyle = current.style
            let alertAction = UIAlertAction(title: actionTitle, style: actionStyle, handler: { (receivedAction) in
                guard let selectedIndex = self.alertController.actions.firstIndex(of: receivedAction) else { return }
                let selectedAction = self.actions[selectedIndex]
                completion?(selectedAction, self.textField?.text)
            })
            alertController.addAction(alertAction)
        }
        
        // Presents created alert controller
        controller.present(alertController, animated: true, completion: nil)
    }
}
