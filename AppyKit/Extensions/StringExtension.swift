//
//  StringExtension.swift
//  Appyist
//
//  Created by Appyist on 18/05/2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import Foundation

public extension String {
    
    // MARK: - Variables
    public var isEmail: Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return range(of: pattern, options: String.CompareOptions.regularExpression, range: nil, locale: nil) != nil
    }
    
    public var isWebAddress: Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
    
    public var isPhoneNumber: Bool {
        if count != 13 || String(self[index(startIndex, offsetBy: 1)]) == "0" {
            return false
        }
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    // MARK: - Functions
    public func trimWhitespaces() -> String {
        let whitespaceSet = NSCharacterSet.whitespaces
        let trimmedString = self.trimmingCharacters(in: whitespaceSet)
        
        return trimmedString == "" ? String() : trimmedString
    }
    
    public func wordCased() -> String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }
    
    public func localized(bundle: Bundle = Bundle(identifier: "ist.appy.AppyKit")!, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }
}
