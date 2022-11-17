//
//  CreateAccountViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 15/11/2022.
//

import UIKit
import ProgressHUD

class UserAuthViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
 
    fileprivate let authPresenter = AuthPrsenter(authApiServices: AuthAPIServices())

    override func viewDidLoad() {
        super.viewDidLoad()

        self.authPresenter.attachView(self)
    }
    
    @IBAction func goAction(_ sender: UIButton) {
      
        guard let phone = phoneTextField.text, phone.isNotEmpty,
              let password = passwordTextField.text, password.isNotEmpty
        else {
            
            Messages().showErrorMessage(title: "Error", body: "please fill all fields")
            sender.shake()
            Vibration.heavy.vibrate()
            return
            
        }
        
        guard phone.isVaildPhone else {
            Messages().showErrorMessage(title: "Error", body: "sorry but phone isn't valid")
            sender.shake()
            Vibration.heavy.vibrate()
            return }
        
        let user = UserRequest(phoneNumber: phone, password: password)
        self.authPresenter.login(user: user)

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
        Messages().showErrorMessage(title: "Error", body: message)
        isModalInPresentation = false
    }
    
    func didRecivedUserAfterRegistration(_ userData: UserResponse) {
        print(userData)
    }
}
