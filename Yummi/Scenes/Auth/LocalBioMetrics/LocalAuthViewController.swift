//
//  LocalAuthViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 26/01/2023.
//

import UIKit

class LocalAuthViewController: UIViewController {

    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var useButton: UIButton!
    @IBOutlet weak var unloclWithLabel: UILabel!
    
    private let biometricIDAuth = BiometricIDAuth()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            doAuth()
    }
    
    fileprivate func doAuth() {
        biometricIDAuth.canEvaluate { (canEvaluate, _, canEvaluateError) in
            guard canEvaluate else {
                alert(title: "Error",
                      message: canEvaluateError?.localizedDescription ?? "Face ID/Touch ID may not be configured",
                      okActionTitle: "Ok")
                return
            }
            
            biometricIDAuth.evaluate { [weak self] (success, error) in
                guard success else {
                    self?.alert(title: "Error",
                                message: error?.localizedDescription ?? "Face ID/Touch ID may not be configured",
                                okActionTitle: "Ok")
                    return
                }
                
                UIView.animate(withDuration: 1.0) {
                    self?.dismiss(animated: true)
                }
            }
        }
    }
    
    @IBAction func useButtonAction(_ sender: Any) {
        doAuth()
    }
    
    func alert(title: String, message: String, okActionTitle: String) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
    fileprivate func blurAnimation() {
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.mainView.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffectView.alpha = 0.4
        
        self.mainView.addSubview(visualEffectView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5, delay: 0.8) {
                visualEffectView.alpha = 1
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        blurAnimation()
    }
}
