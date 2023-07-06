//
//  CreateAccountViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 15/11/2022.
//

import UIKit
import ProgressHUD
import AuthenticationServices

class UserAuthViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
 
    @IBOutlet weak var signInWithApple: ASAuthorizationAppleIDButton!

    fileprivate let authPresenter = AuthPrsenter(authApiServices: AuthAPIServices())

    override func viewDidLoad() {
        super.viewDidLoad()

        self.authPresenter.attachView(self)
        
    }
    
    @IBAction func signInWithAppleAction(_ sender: Any) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
    
    @IBAction func goAction(_ sender: UIButton) {
      
        guard let phone = phoneTextField.text, phone.isNotEmpty,
              let password = passwordTextField.text, password.isNotEmpty
        else {
            
            AlertMessages().showErrorMessage(title: "Error", body: "please fill all fields")
            sender.shake()
            Vibration.heavy.vibrate()
            return
            
        }
        
        guard phone.isVaildPhone else {
            AlertMessages().showErrorMessage(title: "Error", body: "sorry but phone isn't valid")
            sender.shake()
            Vibration.heavy.vibrate()
            return }
        
        let user = UserRequest(phoneNumber: phone, password: password)
        self.authPresenter.login(user: user)

    }
}

extension UserAuthViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        showErrorMessage("Faild to authurization")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let name = credentials.fullName
            let email = credentials.email
            let user = credentials.user
            
            break
            
        default:
            break
        }
    }
}

extension UserAuthViewController: AuthViewDelegate {
    
    func startLoading() {
        ProgressHUD.animationType = .lineScaling
        ProgressHUD.show()
        isModalInPresentation = true
    }
    
    func stopLoading() {
        ProgressHUD.dismiss()
        isModalInPresentation = false
    }
    
    func showErrorMessage(_ message: String) {
        AlertMessages().showErrorMessage(title: "Error", body: message)
        isModalInPresentation = false
    }
    
    func didRecivedUserAfterRegistration(_ userData: UserResponse) {
        print(userData)
    }
}
