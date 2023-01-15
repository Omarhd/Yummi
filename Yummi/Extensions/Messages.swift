//
//  Messages.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 14/09/2022.
//

import UIKit
import SwiftMessages

class Messages {
    public func showTopNotificaionForGoodNetwork() {
        
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.contentMode = .scaleAspectFill
        view.configureContent(title: "Connection Restored", body: "Network now works fine.")
        view.configureTheme(.success, iconStyle: .default)
        view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.button?.isHidden = true
        (view.backgroundView as? CornerRoundingView)?.layer.cornerRadius = 10
        
        SwiftMessages.show(view: view)
    }
    
    
    public func showTopNotificaionForPoorNetwork() {
        
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(.error)
        view.configureDropShadow()
        view.contentMode = .scaleAspectFill
        view.configureContent(title: "No Connection", body: "The Internet connection appears to be offline.")
        view.configureTheme(.error, iconStyle: .default)
        view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.button?.isHidden = true
        (view.backgroundView as? CornerRoundingView)?.layer.cornerRadius = 10
        
        SwiftMessages.show(view: view)
    }
    
    public func showMessage(title : String, body : String) {
        
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.contentMode = .scaleAspectFill
        view.configureContent(title: title, body: body)
        view.configureTheme(.success, iconStyle: .default)
        view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.button?.isHidden = true
        (view.backgroundView as? CornerRoundingView)?.layer.cornerRadius = 10
        
        SwiftMessages.show(view: view)
    }
    
    
    public func showSuccessMessage(title : String, body : String) {
        
        let view = MessageView.viewFromNib(layout: .centeredView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.contentMode = .scaleAspectFill
        view.configureContent(title: title, body: body)
        view.configureTheme(.success, iconStyle: .default)
        view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.button?.isHidden = true
        (view.backgroundView as? CornerRoundingView)?.layer.cornerRadius = 10
        
        SwiftMessages.show(view: view)
    }
    
    
    public func showErrorMessage(title : String, body : String) {
        
        let view = MessageView.viewFromNib(layout: .cardView)
        
        view.configureTheme(.error)
        view.configureDropShadow()
        view.contentMode = .scaleAspectFill
        view.configureContent(title: title, body: body)
        view.configureTheme(.error, iconStyle: .subtle)
        view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.button?.isHidden = false
        view.button?.setTitle("Add Items", for: .normal)
        view.button?.addTarget(self, action: #selector(dosome), for: .allEvents)
        (view.backgroundView as? CornerRoundingView)?.layer.cornerRadius = 10
        
        var config = SwiftMessages.defaultConfig
        config.duration = SwiftMessages.Duration.seconds(seconds: 10) // show in 5 seconds for example
        SwiftMessages.show(config: config, view: view)
    }
    
    @objc func dosome() {
        print("heheheeh")
    }
}
