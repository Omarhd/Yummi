//
//  NotificationsTableViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 05/09/2022.
//

import UIKit

class NotificationsTableViewController: UITableViewController {
    
    weak var delegate: MonsterSelectionDelegate?
    
    let notifications = [
        Notifications(name: "Cat-Bot", description: "MEE-OW",
                      iconName: "meetcatbot", weapon: .sword),
        Notifications(name: "Dog-Bot", description: "BOW-WOW",
                      iconName: "meetdogbot", weapon: .blowgun),
        Notifications(name: "Explode-Bot", description: "BOOM!",
                      iconName: "meetexplodebot", weapon: .smoke),
        Notifications(name: "Fire-Bot", description: "Will Make You Steamed",
                      iconName: "meetfirebot", weapon: .ninjaStar),
        Notifications(name: "Ice-Bot", description: "Has A Chilling Effect",
                      iconName: "meeticebot", weapon: .fire),
        Notifications(name: "Mini-Tomato-Bot", description: "Extremely Handsome",
                      iconName: "meetminitomatobot", weapon: .ninjaStar)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let notification = notifications[indexPath.row]
        cell.textLabel?.text = notification.name
        cell.detailTextLabel?.text = notification.description
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMonster = notifications[indexPath.row]
        delegate?.monsterSelected(selectedMonster)
        if
            let detailViewController = delegate as? NotificationDetailsViewController,
            let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}

protocol MonsterSelectionDelegate: class {
    func monsterSelected(_ newMonster: Notifications)
}
