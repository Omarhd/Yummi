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
    case SIGNAL_LINE_SERVER
    
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
    var siganlLineServer: String?
    
    func setupBaseUrls() {
#if RELEASE
        self.baseURL = BuildSettingsKey.BASE_URL.value
        self.authURL = BuildSettingsKey.AUTH_URL.value
        self.siganlLineServer = BuildSettingsKey.SIGNAL_LINE_SERVER.value
        
#elseif DEBUG
        self.baseURL = BuildSettingsKey.BASE_URL.value
        self.authURL = BuildSettingsKey.AUTH_URL.value
        self.siganlLineServer = BuildSettingsKey.SIGNAL_LINE_SERVER.value

#elseif STAGING
        self.baseURL = BuildSettingsKey.BASE_URL.value
        self.authURL = BuildSettingsKey.AUTH_URL.value
        self.siganlLineServer = BuildSettingsKey.SIGNAL_LINE_SERVER.value

#elseif LOCAL
        self.baseURL = BuildSettingsKey.BASE_URL.value
        self.authURL = BuildSettingsKey.AUTH_URL.value
        self.siganlLineServer = BuildSettingsKey.SIGNAL_LINE_SERVER.value

#else
        self.baseURL = BuildSettingsKey.BASE_URL.value
        self.authURL = BuildSettingsKey.AUTH_URL.value
        self.siganlLineServer = BuildSettingsKey.SIGNAL_LINE_SERVER.value

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
