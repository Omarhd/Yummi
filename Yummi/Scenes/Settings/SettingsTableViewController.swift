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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func modeSwitcherAction(_ sender: Any) {
        if modeSwitcher.isOn {
            if let window = UIApplication.shared.keyWindow {
                UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    window.overrideUserInterfaceStyle = .dark //.light or .unspecified
                }, completion: nil)
            }
        } else {
            if let window = UIApplication.shared.keyWindow {
                UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    window.overrideUserInterfaceStyle = .light //.light or .unspecified
                }, completion: nil)
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
    }
}
