//
//  BiometricsAuthViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 11/12/2022.
//

import UIKit

class BiometricsAuthViewController: UIViewController {

    let touchMe = BiometricIDAuth()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        doAuth()
        
    }
    
    fileprivate func doAuth() {
        touchMe.authenticateUser() { [weak self] message in
            if let message = message {
                let alertView = UIAlertController(title: "Error",
                                                  message: message,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK!", style: .default)
                alertView.addAction(okAction)
                self?.present(alertView, animated: true)
                
            } else {
//                self?.performSegue(withIdentifier: "dismissLogin", sender: self)
            }
        }
    }
}
