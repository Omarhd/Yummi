//
//  PlacesPanelViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 18/10/2022.
//

import UIKit

protocol locationSelectionDelegate {
    func didSelectLocation(lat: Double, long: Double)
}

class PlacesPanelViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let data = mocData
    fileprivate var locationsView: locationSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
}

extension PlacesPanelViewController: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PlacesTableViewCell.identifire, for: indexPath) as! PlacesTableViewCell
       
        cell.textLabel?.text = data[indexPath.row].placeName
        cell.detailTextLabel?.text = data[indexPath.row].placeName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = self.data[indexPath.row]
        self.locationsView?.didSelectLocation(lat: selected.latitude, long: selected.longitude)
    }
}
