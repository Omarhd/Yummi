//
//  SearchBarNavigationController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 08/09/2022.
//

import UIKit

class SearchBarNavigationController: UINavigationBar {
        
    func setupSearchBarWithSegment(_ serachBarObject: UISearchBar){
        serachBarObject.placeholder = "search"
        serachBarObject.showsScopeBar = true
        serachBarObject.barTintColor = UIColor(named: "BG")
        serachBarObject.scopeButtonTitles = ["Apple Music", "Local Music"]
        
        // To change UISegmentedControl color only when appeared in UISearchBar
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .red
        UISegmentedControl.appearance().backgroundColor = .clear

        self.topItem?.titleView = serachBarObject
    }
}
