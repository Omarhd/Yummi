//
//  AppManager.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import Foundation

let kAppToken = "AppToken"
let kUserObject = "UserObject"
let kNewOrderID = "NewOrderID"
let kRetaurantID = "restaurantID"
let kDeviceToken = "access_token"
let kRestaurantObject = "restaurant"

class AppManager: NSObject {
    static let sharedInstance: AppManager = AppManager()
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func saveAppToken(token: String) {
        userDefaults.set(token, forKey: kAppToken)
        userDefaults.synchronize()
    }
    func getAppToken() -> String?{
        return userDefaults.string(forKey: kAppToken)
    }
    
    func saveNewOrderID(orderID: String) {
        userDefaults.setValue(orderID, forKey: kNewOrderID)
        userDefaults.synchronize()
    }
    func saveDeviceToken(token: String) {
        userDefaults.setValue(token, forKey: kDeviceToken)
        userDefaults.synchronize()
    }
    
    func getNewOrderID() -> String? {
        return userDefaults.string(forKey: kNewOrderID)
    }
    
    func getDeviceToken() -> String? {
        return userDefaults.string(forKey: kDeviceToken)
    }
    
    func getRestaurantID() -> String? {
        return userDefaults.string(forKey: kRetaurantID)
    }
    
    // MARK: App      Tutorial=============================================================================================================
    static func setUserSeenAppInstructionForHome() {
        UserDefaults.standard.set(true, forKey: "userSeenShowCaseForHome")
    }
    
    static func setUserSeenAppInstructionForDishDetails() {
        UserDefaults.standard.set(true, forKey: "userSeenShowCaseForDishDetails")
    }
    
    static func getUserSeenAppInstructionForHome() -> Bool {
        let userSeenShowCaseObject = UserDefaults.standard.object(forKey: "userSeenShowCaseForHome")
        if let userSeenShowCase = userSeenShowCaseObject as? Bool {
            return userSeenShowCase
        }
        return false
    }
    
    static func getUserSeenAppInstructionForDishDetails() -> Bool {
        let userSeenShowCaseObject = UserDefaults.standard.object(forKey: "userSeenShowCaseForDishDetails")
        if let userSeenShowCase = userSeenShowCaseObject as? Bool {
            return userSeenShowCase
        }
        return false
    }
}
