//
//  ViewControllerNavigators.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 04/09/2022.
//

import UIKit

extension UIViewController {
    
    static var identifire: String {
        return String(describing: self)
    }
    
    static func instantiate(storyBoardName: String) -> Self {
        
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: nil)
        let controller = storyBoard.instantiateViewController(withIdentifier: identifire) as! Self
        
        return controller
    }
}
