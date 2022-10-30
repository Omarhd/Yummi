//
//  SearchViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 07/09/2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyResultView: UIImageView!
  
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
        searchController.searchBar.scopeButtonTitles = ["All", "Macs", "iPhones"]
        searchController.searchBar.showsScopeBar = true
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor(named: "Cells")
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).selectedSegmentTintColor = UIColor(named: "AppColor")

        searchController.searchBar.setScopeBarButtonTitleTextAttributes(segAttributes as? [NSAttributedString.Key : Any], for: UIControl.State.selected)
        self.filteredData = self.tableData
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchController.isActive = true
        navigationItem.hidesSearchBarWhenScrolling = true
    }
}

extension SearchViewController: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        if text != "" {
            filteredData = self.tableData.map({ $0 }).filter ({
                $0.lowercased().contains(text.lowercased())})
            
            
            if filteredData.isEmpty {
                self.emptyResultView.isHidden = false
            } else {
                self.emptyResultView.isHidden = true
            }
            self.tableView.reloadData()

        } else {
            filteredData = self.tableData
            self.tableView.reloadData()
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
