//
//  MainTabBarController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 29/10/2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateBadge(with: "2")
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[2]
            tabItem.badgeValue = "1"
        }
    }
    
    func updateBadge(with count: String) {
        let item = tabBar.items?[2]
        item?.badgeValue = count
        
    }
}
