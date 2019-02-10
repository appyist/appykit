//
//  ImagePickableController.swift
//  Appykit
//
//  Created by Appyist on 29/04/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import Foundation
import UIKit
import Photos

public protocol ImagePickable: class, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    var imageKey: String { get }
    var allowsEditing: Bool { get }
    var presenterController: UIViewController { get }
    var sourceType: UIImagePickerControllerSourceType { get }
    
    // MARK: - Functions
    func presentPhotoLibrary()
    func presentCamera()
}

public extension ImagePickable {
    
    // MARK: - Properties
    var allowsEditing: Bool {
        return true
    }
    var sourceType: UIImagePickerControllerSourceType {
        return .photoLibrary
    }
    var imageKey: String {
        return allowsEditing ? UIImagePickerControllerEditedImage : UIImagePickerControllerOriginalImage
    }
    
    // MARK: - Functions
    func imagePickerController(withSourceType type: UIImagePickerControllerSourceType) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.navigationBar.backIndicatorImage = nil
        controller.delegate = self
        controller.sourceType = type
        controller.allowsEditing = allowsEditing
        
        return controller
    }
    
    func presentPhotoLibrary() {
        PHPhotoLibrary.requestAuthorization { (status) in
            DispatchQueue.main.async {
                if status == .authorized {
                    let controller = self.imagePickerController(withSourceType: .photoLibrary)
                    self.presenterController.present(controller, animated: true, completion: nil)
                }else {
                    let alert = AppyAlertControllerBuilder.noAccessToPhotoLibrary
                    alert.present(in: self.presenterController, completion: nil)
                }
            }
        }
    }
    
    func presentCamera() {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (success) in
            DispatchQueue.main.async {
                if success {
                    let controller = self.imagePickerController(withSourceType: .camera)
                    self.presenterController.present(controller, animated: true, completion: nil)
                }else {
                    let alert = AppyAlertControllerBuilder.noAccessToCamera
                    alert.present(in: self.presenterController, completion: nil)
                }
            }
        }
    }
}

extension ImagePickable where Self: UIViewController {
    
    var presenterController: UIViewController {
        return self
    }
}

fileprivate extension AppyAlertAction {
    
    // MARK: - Properties
    static let takePhoto = AppyAlertAction(title: "Take Photo".localized(tableName: "AlertAction"))
    static let chooseFromLibrary = AppyAlertAction(title: "Choose from Library".localized(tableName: "AlertAction"))
}

fileprivate extension AppyAlertControllerBuilder {
    
    // MARK: - Properties
    class var tableName: String {
        return "AlertControllerBuilder"
    }
    
    class var noAccessToCamera: AppyAlertControllerBuilder {
        let title = "No access to camera.".localized(tableName: tableName)
        let message = "You can enable access in Privacy Settings.".localized(tableName: tableName)
        let builder = AppyAlertControllerBuilder(title: title, message: message, actions: [.okay], style: .alert)
        
        return builder
    }
    
    class var noAccessToPhotoLibrary: AppyAlertControllerBuilder {
        let title = "No access to your photos.".localized(tableName: tableName)
        let message = "You can enable access in Privacy Settings.".localized(tableName: tableName)
        let builder = AppyAlertControllerBuilder(title: title, message: message, actions: [.okay], style: .alert)
        
        return builder
    }
}
