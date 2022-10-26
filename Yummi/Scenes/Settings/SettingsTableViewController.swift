//
//  SettingsTableViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 12/09/2022.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var modeSwitcher: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSwitcherStatus()
    }
    @IBAction func modeSwitcherAction(_ sender: Any) {
        if modeSwitcher.isOn {
            if let window = UIApplication.shared.keyWindow {
                UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    window.overrideUserInterfaceStyle = .dark //.light or .unspecified
                }, completion: nil)
                UserDefaults.standard.defaultDarkAppearnce = true
                UserDefaults.standard.setDefaultAppearance = 2
            }
        } else {
            if let window = UIApplication.shared.keyWindow {
                UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    window.overrideUserInterfaceStyle = .light //.light or .unspecified
                }, completion: nil)
                UserDefaults.standard.setDefaultAppearance = 1
            }
        }
    }
    
    fileprivate func setupSwitcherStatus() {
        if UserDefaults.standard.setDefaultAppearance == 2 {
            self.modeSwitcher.isOn = true
        } else {
            self.modeSwitcher.isOn = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupSwitcherStatus()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    }
}

extension SettingsTableViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
  
    override var shouldAutorotate: Bool {
        return false
    }

}
