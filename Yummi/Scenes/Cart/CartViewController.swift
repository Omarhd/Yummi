//
//  CartViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 04/09/2022.
//

import UIKit
import LocalAuthentication

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyCartView: UIView!
    
    // MARK:- refrence to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    var cartItem: [Products] = []
    let touchMe = BiometricIDAuth()

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchProducts()
        if cartItem.count == 0 {
            emptyCartView.isHidden = false
        } else {
            emptyCartView.isHidden = true
        }
        registerNibs()
    }
    
    func fetchProducts() {
        do {
            self.cartItem = try context.fetch(Products.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            
        }
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: CartItemsTableViewCell.identifire, bundle: nil), forCellReuseIdentifier: CartItemsTableViewCell.identifire)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        doAuth()
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemsTableViewCell.identifire, for: indexPath) as! CartItemsTableViewCell
        
        cell.setupUI(with: cartItem[indexPath.row])
        
        return cell
    }
    
    
}

extension CartViewController {
    
    fileprivate func doAuth() {
        touchMe.authenticateUser() { [weak self] message in
            if let message = message {
                // if the completion is not nil show an alert
                let alertView = UIAlertController(title: "Error",
                                                  message: message,
                                                  preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Darn!", style: .default)
                alertView.addAction(okAction)
                self?.present(alertView, animated: true)
                
            } else {
//                self?.performSegue(withIdentifier: "dismissLogin", sender: self)
            }
        }
    }
    
    func checkLogin(username: String, password: String) -> Bool {
      guard username == UserDefaults.standard.value(forKey: "username") as? String else {
        return false
      }
      
      do {
        let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                account: username,
                                                accessGroup: KeychainConfiguration.accessGroup)
        let keychainPassword = try passwordItem.readPassword()
        return password == keychainPassword
      }
      catch {
        fatalError("Error reading password from keychain - \(error)")
      }
      return false
    }
    
    private func showLoginFailedAlert() {
      let alertView = UIAlertController(title: "Login Problem",
                                        message: "Wrong username or password.",
                                        preferredStyle:. alert)
      let okAction = UIAlertAction(title: "Foiled Again!", style: .default)
      alertView.addAction(okAction)
      present(alertView, animated: true)
    }
}
