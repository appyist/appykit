//
//  DateComponentsFormatterExtension.swift
//  AppyKit
//
//  Created by Emirhan Erdogan on 13.04.2018.
//  Copyright © 2018 ilker. All rights reserved.
//

import Foundation

public extension DateComponentsFormatter {
    
    public enum TimeIntervalFormat {
        case abbreviated
        case short
        case full
    }
    
    // MARK: - Properties
    fileprivate class var tableName: String {
        return "DateComponentsFormatter"
    }
    
    // MARK: - Functions
    public class func timePassed(since date: Date, format: TimeIntervalFormat) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.maximumUnitCount = 1
        
        var timeIntervalString: String?
        var localizedTimeIntervalString: String?
        
        switch format {
        case .abbreviated:
            formatter.unitsStyle = .abbreviated
            timeIntervalString = formatter.string(from: date, to: Date())
            
            return timeIntervalString
        case .short:
            formatter.unitsStyle = .short
        case .full:
            formatter.unitsStyle = .full
        }
        
        timeIntervalString = formatter.string(from: date, to: Date())
        
        if let timeIntervalString = timeIntervalString {
            if Calendar.current.dateComponents([.second], from: date, to: Date()).second! <= 10 {
                localizedTimeIntervalString = "now".localized(tableName: tableName)
            }else {
                let agoText = "ago".localized(tableName: tableName)
                localizedTimeIntervalString = timeIntervalString
                
                if format != .short {
                    localizedTimeIntervalString! += " \(agoText)"
                }
            }
            
            return localizedTimeIntervalString
        }
        
        return timeIntervalString
    }
}
