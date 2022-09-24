//
//  Messages.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 14/09/2022.
//

import UIKit
import SwiftMessages

func showTopNotificaionForGoodNetwork(title : String, body : String) {
    
    let view = MessageView.viewFromNib(layout: .statusLine)
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

func showMessage(title : String, body : String) {
    
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


func showSuccessMessage(title : String, body : String) {
    
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


func showErrorMessage(title : String, body : String) {
    
    let view = MessageView.viewFromNib(layout: .cardView)
    view.configureTheme(.error)
    view.configureDropShadow()
    view.contentMode = .scaleAspectFill
    view.configureContent(title: title, body: body)
    view.configureTheme(.success, iconStyle: .default)
    view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    view.button?.isHidden = true
    (view.backgroundView as? CornerRoundingView)?.layer.cornerRadius = 10
    
    SwiftMessages.show(view: view)
}
