//
//  ChatViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 28/11/2022.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let mocData = [People(name: "Omar Abdulrahman", seen: "recently", image: UIImage(systemName: "person.circle.fill")!),
                   People(name: "Amin Jalal", seen: "2 days ago", image: UIImage(systemName: "person.circle")!),
                   People(name: "Mujtaba", seen: "1 miniute", image: UIImage(systemName: "person")!) ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mocData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell")
        cell?.textLabel?.text = self.mocData[indexPath.row].name
        cell?.detailTextLabel?.text = self.mocData[indexPath.row].seen
        cell?.imageView?.image = self.mocData[indexPath.row].image
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatDetailsViewController = ChatDetailsViewController()
        chatDetailsViewController.title = self.mocData[indexPath.row].name
        self.navigationController?.pushViewController(chatDetailsViewController, animated: true)
    }
}
