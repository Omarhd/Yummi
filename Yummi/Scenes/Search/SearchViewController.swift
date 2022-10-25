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
    let tableData = ["Mac", "iPhone", "iPod", "iOS", "MacOS", "WatchOS"]
    var filteredData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
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
