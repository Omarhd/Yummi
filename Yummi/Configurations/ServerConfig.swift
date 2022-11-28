//
//  ServerConfig.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 16/09/2022.
//

import Foundation

enum BuildSettingsKey: String {
    
    case BASE_URL
    case AUTH_URL
    
    var value: String {
        get {
            return Bundle.main.infoDictionary![self.rawValue] as! String
        }
    }
}

class ServerConfig {
    
    static let shared = ServerConfig()
    
    var baseURL: String?
    var authURL: String?
    
    func setupBaseUrls() {
#if RELEASE
        self.baseURL = BuildSettingsKey.BASE_URL.value
        self.authURL = BuildSettingsKey.AUTH_URL.value
#elseif DEBUG
        self.baseURL = BuildSettingsKey.BASE_URL.value
        self.authURL = BuildSettingsKey.AUTH_URL.value
#elseif STAGING
        self.baseURL = BuildSettingsKey.BASE_URL.value
        self.authURL = BuildSettingsKey.AUTH_URL.value
#elseif LOCAL
        self.baseURL = BuildSettingsKey.BASE_URL.value
        self.authURL = BuildSettingsKey.AUTH_URL.value
#else
        self.baseURL = BuildSettingsKey.BASE_URL.value
        self.authURL = BuildSettingsKey.AUTH_URL.value
#endif
        
    }
    
    func setupGoogleInfo() -> String {
       
        var filePath: String!
        
#if RELEASE
        filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "Google-Info/Release")
#elseif DEBUG
        filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "Google-Info/Debug")
#elseif STAGING
        filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "Google-Info/Staging")
#elseif Local
        filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "Google-Info/Local")
#else
        filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist", inDirectory: "Google-Info/Release")
#endif
  
        return "filePath"
    }
}
