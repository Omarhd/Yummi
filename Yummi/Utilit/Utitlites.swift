//
//  Utitlites.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import UIKit

enum Language : String{
    case english = "en"
    case arabic = "ar"
}

class Utility {
    func currentApplicationLanguage() -> Language{
        let currentAppLanguage = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        let languageCode = currentAppLanguage?.first

        if(languageCode?.hasPrefix("en"))!{
            return Language.english
        }else if(languageCode?.hasPrefix("ar"))!{
            return Language.arabic
        }

        
        return Language.english
    }
    
    func currentApplicationLanguageCode() -> String{
        let currentAppLanguage = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        let languageCode = currentAppLanguage?.first
        return languageCode ?? ""
    }

    
    // MARK: Application Language Change
    func changeApplicationLanguage(){
        let currentAppLanguageCode = self.currentApplicationLanguageCode()
        if(currentAppLanguageCode.hasPrefix("en")) { // == "en"){
            UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
        }else{
            UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
        }
        UserDefaults.standard.synchronize()
    }
}
