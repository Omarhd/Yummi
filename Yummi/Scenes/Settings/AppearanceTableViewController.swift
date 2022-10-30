//
//  AppearanceTableViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 07/10/2022.
//

import UIKit

class AppearanceTableViewController: UITableViewController {

    @IBOutlet weak var lightCell: UITableViewCell!
    @IBOutlet weak var darkCell: UITableViewCell!
    @IBOutlet weak var systemCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCheckMarks()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("1")
            lightCell.accessoryType = .checkmark
            darkCell.accessoryType = .none
            systemCell.accessoryType = .none
            self.setAppearance(.light)
            UserDefaults.standard.setDefaultAppearance = 1
            self.dismiss(animated: true)

        case 1:
            print("2")
            lightCell.accessoryType = .none
            darkCell.accessoryType = .checkmark
            systemCell.accessoryType = .none
            self.setAppearance(.dark)
            UserDefaults.standard.setDefaultAppearance = 2
            self.dismiss(animated: true)

        case 2:
            print("3")
            lightCell.accessoryType = .none
            darkCell.accessoryType = .none
            systemCell.accessoryType = .checkmark
            self.setAppearance(.unspecified)
            UserDefaults.standard.setDefaultAppearance = 0
            self.dismiss(animated: true)

        default:
            break
        }
    }
    
    fileprivate func setAppearance(_ style: UIUserInterfaceStyle) {
        if let window = UIApplication.shared.keyWindow {
            UIView.transition (with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                if #available(iOS 13.0, *) {
                    window.overrideUserInterfaceStyle = style
                } else {
                    // Fallback on earlier versions
                } //.light or .unspecified
            }, completion: nil)
        }
    }
    
    fileprivate func setupCheckMarks() {
        if UserDefaults.standard.setDefaultAppearance == 1 {
            lightCell.accessoryType = .checkmark
            darkCell.accessoryType = .none
            systemCell.accessoryType = .none
            
        } else if UserDefaults.standard.setDefaultAppearance == 2 {
            lightCell.accessoryType = .none
            darkCell.accessoryType = .checkmark
            systemCell.accessoryType = .none
            
        } else if UserDefaults.standard.setDefaultAppearance == 0 {
            lightCell.accessoryType = .none
            darkCell.accessoryType = .none
            systemCell.accessoryType = .checkmark
            
        }
    }
}
