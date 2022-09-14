//
//  SearchViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 07/09/2022.
//

import UIKit

class SearchViewController: UIViewController {

    let bar = SearchBarNavigationController()
    let searchBar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bar.setupSearchBarWithSegment(searchBar)
    }
}
