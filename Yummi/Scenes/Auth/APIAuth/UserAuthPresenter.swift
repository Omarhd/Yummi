//
//  AuthPresenter.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 17/11/2022.
//

import Foundation
import UIKit

protocol AuthViewDelegate: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func showErrorMessage(_ message: String)
    func didRecivedUserAfterRegistration(_ userData: UserResponse)
}

class AuthPrsenter {
    
    fileprivate let authApiServices: AuthAPIServices
    weak fileprivate var authView: AuthViewDelegate?
    
    init(authApiServices: AuthAPIServices) {
        self.authApiServices = authApiServices
    }
    
    func attachView(_ view: AuthViewDelegate) {
        self.authView = view
    }
    
    func detachView() {
        self.authView = nil
    }
    
    func login(user: UserRequest) {
        self.authView?.startLoading()
        self.authApiServices.login(prameters: user) { Result in
            switch Result {
            case .success(let userData):
                self.authView?.didRecivedUserAfterRegistration(userData)
                self.authView?.stopLoading()
            case .failure(let error):
                var messageToShow = ""
                switch error {
                case .backend(let backendError):
                    messageToShow = backendError.message!
                case .network(let message):
                    messageToShow = message
                case .parsing(let errorDesc, let statusCode):
                    messageToShow = "Issue in data try aganin later".localizable()
                    print("status Code \(statusCode)")
                    print("Error Dec \(errorDesc)")
                }
                self.authView?.stopLoading()
                self.authView?.showErrorMessage(messageToShow)
            }
        }
    }
}
