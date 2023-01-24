//
//  CategoryDetailsViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 05/09/2022.
//

import UIKit
import UIView_Shimmer

class CategoryDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var categories: [Category] = []
    
    
    private var isLoading = true {
        didSet {
            tableView.isUserInteractionEnabled = !isLoading
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibs()
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: CategoryDetailsTableViewCell.identifire, bundle: nil), forCellReuseIdentifier: CategoryDetailsTableViewCell.identifire)
    }
}

extension CategoryDetailsViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryDetailsTableViewCell.identifire, for: indexPath) as! CategoryDetailsTableViewCell
        cell.setupUI(with: self.categories[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }
}
