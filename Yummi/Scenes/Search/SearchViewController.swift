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
    
    var shapeList = [Shape]()
    var filteredShapes = [Shape]()
    
    let segAttributes: NSDictionary = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "Futura", size: 16)!
    ]
    
    var filteredData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initList()
        self.initSearchController()
    }
    
    func initSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["All", "Rect", "Square", "Oct", "Circle", "Triangle"]
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor(named: "Cells")
        UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self]).selectedSegmentTintColor = UIColor(named: "AppColor")
        
        searchController.searchBar.setScopeBarButtonTitleTextAttributes(segAttributes as? [NSAttributedString.Key : Any], for: UIControl.State.selected)
        searchController.searchBar.delegate = self
    }
    
    func initList() {
        let circle = Shape(id: "0", name: "Circle 1", imageName: "circle")
        shapeList.append(circle)
        
        let square = Shape(id: "1", name: "Square 1", imageName: "squareshape")
        shapeList.append(square)
        
        let octagon = Shape(id: "2", name: "Octagon 1", imageName: "octagon")
        shapeList.append(octagon)
        
        let rectangle = Shape(id: "3", name: "Rectangle 1", imageName: "rectangle")
        shapeList.append(rectangle)
        
        let triangle = Shape(id: "4", name: "Triangle 1", imageName: "triangle")
        shapeList.append(triangle)
        
        let circle2 = Shape(id: "5", name: "Circle 2", imageName: "circle")
        shapeList.append(circle2)
        
        let square2 = Shape(id: "6", name: "Square 2", imageName: "square")
        shapeList.append(square2)
        
        let octagon2 = Shape(id: "7", name: "Octagon 2", imageName: "octagon")
        shapeList.append(octagon2)
        
        let rectangle2 = Shape(id: "8", name: "Rectangle 2", imageName: "rectangle")
        shapeList.append(rectangle2)
        
        let triangle2 = Shape(id: "9", name: "Triangle 2", imageName: "triangle")
        shapeList.append(triangle2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchController.isActive = true
        navigationItem.hidesSearchBarWhenScrolling = true
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        self.emptyResultView.isHidden = true

        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
       
        if filteredData.isEmpty {
            self.emptyResultView.isHidden = false
        } else {
            self.emptyResultView.isHidden = true
        }
    }
    
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "All") {

        filteredShapes = shapeList.filter { shape in
            self.emptyResultView.isHidden = true

            let scopeMatch = (scopeButton == "All" || shape.name.lowercased().contains(scopeButton.lowercased()))
            if(searchController.searchBar.text != "") {
                let searchTextMatch = shape.name.lowercased().contains(searchText.lowercased())
                return scopeMatch && searchTextMatch
            } else {
                self.emptyResultView.isHidden = true
                return scopeMatch
            }
        }
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchController.isActive) {
            return filteredShapes.count
        }
        return shapeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifire, for: indexPath) as! SearchTableViewCell
        
        
        if(searchController.isActive) {
            cell.setup(filteredShapes[indexPath.row])
        } else {
            cell.setup(shapeList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
