//
//  StringLocalization.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import UIKit

extension String {
    func localizable() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localization",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
    
    var asURL: URL? {
        return URL(string: self)
    }
    
    var isNotEmpty: Bool {
        return !isEmpty
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var isVaildPhone: Bool {
        
        let PHONEREGEX = "^([1-9][0-9]*)|([0]+)$"
        let phone = "^\\d{3}-\\d{3}-\\d{4}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES%@", PHONEREGEX, phone)
        
        return emailPredicate.evaluate(with: self)
    }
}

