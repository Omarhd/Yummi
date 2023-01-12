//
//  BalaceViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 18/09/2022.
//

import UIKit

class BalaceViewController: UIViewController {

    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        mainView.addGestureRecognizer(tap)
        
        self.isModalInPresentation = true

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
       dismiss(animated: true)
    }
}
