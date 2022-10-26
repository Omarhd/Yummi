//
//  SearchViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 07/09/2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    
    let tableData = ["Mac", "iPhone", "iPod", "iOS", "MacOS", "WatchOS", "Macss", "iPhoness", "iPodss", "iOSss", "MacOSss", "WatchOSss", "Macww", "iPhoneww", "iPodww", "iOSww", "MacOSww", "WatchOSww"]
    let segAttributes: NSDictionary = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "Futura", size: 16)!
    ]

    var filteredData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchBar.scopeButtonTitles = ["Phones", "Macs", "Others"]
        searchController.searchBar.setScopeBarButtonTitleTextAttributes(segAttributes as? [NSAttributedString.Key : Any], for: UIControl.State.normal)
        searchController.searchBar.showsScopeBar = true
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor(named: "Cells")
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).selectedSegmentTintColor = UIColor(named: "AppColor")

        searchController.searchBar.setScopeBarButtonTitleTextAttributes(segAttributes as? [NSAttributedString.Key : Any], for: UIControl.State.selected)
        self.filteredData = self.tableData
    }
}

extension SearchViewController: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        if text != "" {
            filteredData = self.tableData.map({ $0 }).filter ({
                $0.lowercased().contains(text.lowercased())})
            
            self.tableView.reloadData()
        } else {
            filteredData = self.tableData
            self.tableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        if selectedScope == 0 {
            print("helloo 00")
        } else {
            print("hello 11")
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.filteredData[indexPath.row]
        
        return cell
    }
}
