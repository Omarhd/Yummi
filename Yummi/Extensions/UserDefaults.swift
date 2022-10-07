//
//  UserDefaults.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 14/09/2022.
//

import Foundation
extension UserDefaults {
    
    private enum UserDefaultsKeys: String {
        case hasOnBoarded
        case defaultDarkAppearnce
        case setDefaultAppearance
    }
    
    var hasOnBoarded: Bool {
        get {
            bool(forKey: UserDefaultsKeys.hasOnBoarded.rawValue)
        }
        
        set {
            set(newValue, forKey: UserDefaultsKeys.hasOnBoarded.rawValue)
        }
    }
    
    var defaultDarkAppearnce: Bool {
        get {
            bool(forKey: UserDefaultsKeys.defaultDarkAppearnce.rawValue)
        }
        
        set {
            set(newValue, forKey: UserDefaultsKeys.defaultDarkAppearnce.rawValue)
        }
    }
    
    var setDefaultAppearance: Int {
        get {
            Int(integer(forKey: UserDefaultsKeys.setDefaultAppearance.rawValue))
        }
        set {
            set(newValue, forKey: UserDefaultsKeys.setDefaultAppearance.rawValue)
        }
    }
}
