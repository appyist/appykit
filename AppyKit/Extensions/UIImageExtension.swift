//
//  UIImageExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 15.01.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

public extension UIImage {
    
    public enum ImageFormat {
        case jpeg(compression: CGFloat)
        case png
    }
    
    
    // MARK: - Initializers
    convenience init?(named: String, classForCoder: AnyClass, compatibleWith traitCollection: UITraitCollection) {
        let bundle = Bundle(for: classForCoder)
        self.init(named: named, in: bundle, compatibleWith: traitCollection)
    }
    
    // MARK: - Functions
    func base64Encoded(withFormat format: ImageFormat) -> String? {
        var imageData: Data?
        
        switch format {
        case .jpeg(let compression):
            imageData = UIImageJPEGRepresentation(self, compression)
        case .png:
            imageData = UIImagePNGRepresentation(self)
        }
        
        return imageData?.base64EncodedString()
    }
}
