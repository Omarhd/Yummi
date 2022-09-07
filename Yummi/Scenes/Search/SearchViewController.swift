//
//  SearchViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 07/09/2022.
//

import UIKit

class SearchViewController: UIViewController {

    let searchBar = UISearchBar()
    

    fileprivate func setupSearchBarWithSegment(_ serachBarObject: UISearchBar){
        self.searchBar.placeholder = "search"
        self.searchBar.showsScopeBar = true
        self.searchBar.barTintColor = UIColor(named: "BG")
        self.searchBar.scopeButtonTitles = ["Apple Music", "Local Music"]
        
        // To change UISegmentedControl color only when appeared in UISearchBar
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .red
        UISegmentedControl.appearance().backgroundColor = .clear
        
        self.navigationItem.titleView = self.searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBarWithSegment(searchBar)

    }
}
