//
//  CartViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 04/09/2022.
//

import UIKit
import ProgressHUD
import LocalAuthentication

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyCartView: UIView!
    @IBOutlet weak var detailsView: CardView!
    
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var deliveryChargeLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var haLoggedIn: Bool = false
    
    // MARK:- refrence to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
   
    var cartItem: [Products] = []
    var totalPrice: String?
    
    let touchMe = BiometricIDAuth()

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchProducts()
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
        
        setupEmptyViewTableView()
        setupCartDetails()
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: CartItemsTableViewCell.identifire, bundle: nil), forCellReuseIdentifier: CartItemsTableViewCell.identifire)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        if haLoggedIn {
            doAuth()
        } else {
            let auth = AuthViewController.instantiate(storyBoardName: "Auth")
            auth.modalPresentationStyle = .formSheet

            self.present(auth, animated: true, completion: nil)
        }
    }
    
    fileprivate func presentDeleteAlert() {
        let alertController = UIAlertController (
            title: "Are You Sure!",
            message: "You can login later any time",
            preferredStyle: UIAlertController.Style.alert
        )
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        let standard = UserDefaults.standard
        let okayAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            ProgressHUD.animationType = .circleRotateChase
            ProgressHUD.show()
            
            for object in self.cartItem {
                self.context.delete(object)
            }
            
            do {
                try self.context.save()
                showSuccessMessage(title: "Done", body: "Cart is Clear.")
                ProgressHUD.dismiss()
                
            } catch {
                showErrorMessage(title: "Error", body: "Can't Remove items for now.")
            }
            
            self.fetchProducts()
        }
        
        alertController.addAction(okayAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    @IBAction func trashAction(_ sender: Any) {
        
        if cartItem.isEmpty {
            showErrorMessage(title: "Empty", body: "Cart Already Empty need to add items")
        } else {
            presentDeleteAlert()
        }
    }
    
    fileprivate func setupCartDetails() {
        self.itemsCountLabel.text = "\(self.cartItem.count)"
        self.deliveryChargeLabel.text = "\(1800)"
        self.totalPriceLabel.text = self.totalPrice
    }
    
    fileprivate func setupEmptyViewTableView() {
        if cartItem.count == 0 {
            emptyCartView.isHidden = false
        } else {
            emptyCartView.isHidden = true
        }
    }
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemsTableViewCell.identifire, for: indexPath) as! CartItemsTableViewCell
        
        cell.setupUI(with: cartItem[indexPath.row])
        
        let total = Double(self.cartItem.count) * cartItem[indexPath.row].price
        self.totalPrice = "\(total)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Remove") { action, view, complection in
            let item = self.cartItem[indexPath.row]
            
            self.context.delete(item)
            
            do {
                try self.context.save()
                showSuccessMessage(title: "Done", body: "Removed item.")

            } catch {
                showErrorMessage(title: "Error", body: "Can't Remove items for now.")
            }
            
            self.fetchProducts()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
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
