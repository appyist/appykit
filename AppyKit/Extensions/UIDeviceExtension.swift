//
//  UIDeviceExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 18.11.2017.
//  Copyright © 2017 ilker. All rights reserved.
//

import Foundation
import UIKit

public extension UIDevice {
    
    public enum ScreenType: Int, Comparable {
        case iPhone4s = 0
        case iPhoneSE = 1
        case iPhone8 = 2
        case iPhone8Plus = 3
        case iPhoneX = 4
        case iPhoneXsMax = 5
        case unknown = -1
        
        // MARK: - Comparable Confirmance
        public static func < (a: ScreenType, b: ScreenType) -> Bool {
            return a.rawValue < b.rawValue
        }
        
        public static func > (a: ScreenType, b: ScreenType) -> Bool {
            return a.rawValue > b.rawValue
        }
        
        public static func <= (a: ScreenType, b: ScreenType) -> Bool {
            return a.rawValue <= b.rawValue
        }
        
        public static func >= (a: ScreenType, b: ScreenType) -> Bool {
            return a.rawValue >= b.rawValue
        }
        
        public static func == (a: ScreenType, b: ScreenType) -> Bool {
            return a.rawValue == b.rawValue
        }
    }
    
    public var screenSize: ScreenType {
        guard UIDevice().userInterfaceIdiom == .phone else { return .unknown }
        let nativeBounds = UIScreen.main.nativeBounds.height
        
        switch nativeBounds {
        case 960.0:
            return .iPhone4s
        case 1136.0:
            return .iPhoneSE
        case 1334.0:
            return .iPhone8
        case 2208.0:
            return .iPhone8Plus
        case 2436.0:
            return .iPhoneX
        case 2688.0:
            return .iPhoneXsMax
        default:
            return .unknown
        }
    }
}
