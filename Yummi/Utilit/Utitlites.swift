//
//  Utitlites.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import UIKit
import LocalAuthentication

enum Language : String{
    case english = "en"
    case arabic = "ar"
}

class Utility: UIViewController {
    
    func currentApplicationLanguage() -> Language {
        let currentAppLanguage = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        let languageCode = currentAppLanguage?.first
        
        if(languageCode?.hasPrefix("en"))!{
            return Language.english
        }else if(languageCode?.hasPrefix("ar"))!{
            return Language.arabic
        }
        
        
        return Language.english
    }
    
    func currentApplicationLanguageCode() -> String {
        let currentAppLanguage = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        let languageCode = currentAppLanguage?.first
        return languageCode ?? ""
    }
    
    
    // MARK: Application Language Change
    func changeApplicationLanguage() {
        let currentAppLanguageCode = self.currentApplicationLanguageCode()
        if(currentAppLanguageCode.hasPrefix("en")) { // == "en"){
            UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
        }else{
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        }
        UserDefaults.standard.synchronize()
    }
    
    public func doLocalAuthentication() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Please use your Passcode"
        
        var authorizationError: NSError?
        let reason = "Authentication required to access the secure data"
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                
                if success {
                    DispatchQueue.main.async() {
                        let alert = UIAlertController(title: "Success", message: "Authenticated succesfully!", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                } else {
                    // Failed to authenticate
                    DispatchQueue.main.async() {
                        let vc = BiometricsAuthViewController()
                        self.present(vc, animated: true)
                    }
                    guard let error = evaluateError else {
                        return
                    }
                    print(error)
                    
                }
            }
        } else {
            
            guard let error = authorizationError else {
                return
            }
            print(error)
        }
    }
}
