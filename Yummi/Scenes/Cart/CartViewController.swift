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
        
    fileprivate let cartPresenter = CartPresenter()

    var cartItems: [Products] = []
    var totalPrice: String?
    
    let touchMe = BiometricIDAuth()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.cartPresenter.attachView(self)
       
        cartPresenter.fetchProducts()
        registerNibs()
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: CartItemsTableViewCell.identifire, bundle: nil), forCellReuseIdentifier: CartItemsTableViewCell.identifire)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        if UserDefaults.standard.hasLoggedIn {
            doAuth()
        } else {
            
            let auth = UserAuthViewController.instantiate(storyBoardName: "Auth")
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
        let okayAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            self.cartPresenter.emptyAllCart()
        }
        
        alertController.addAction(okayAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    @IBAction func trashAction(_ sender: Any) {
        
        if self.cartItems.isEmpty {
            Messages().showErrorMessage(title: "Empty", body: "Cart Already Empty need to add items")
        } else {
            presentDeleteAlert()
        }
    }
    
    fileprivate func setupCartDetails() {
        self.itemsCountLabel.text = "\(self.cartItems.count)"
        self.deliveryChargeLabel.text = "\(1800)"
        self.totalPriceLabel.text = self.totalPrice
    }
    
    fileprivate func setupEmptyViewTableView() {
            emptyCartView.isHidden = false
    }
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemsTableViewCell.identifire, for: indexPath) as! CartItemsTableViewCell
        
        cell.setupUI(with: cartItems[indexPath.row])
        
        let total = Double(self.cartItems.count) * cartItems[indexPath.row].price
        self.totalPrice = "\(total)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Remove") { action, view, complection in
            let item = self.cartItems[indexPath.row]
            self.cartPresenter.deleteItem(item: item)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension CartViewController {
    
    fileprivate func doAuth() {
        touchMe.authenticateUser() { [weak self] message in
            if let message = message {
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

extension CartViewController: CartViewDelegate {
    func startLoading() {
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.show()
    }
    
    func stopLoading() {
        ProgressHUD.dismiss()

    }
    
    func showErrorMessage(_ message: String) {
        ProgressHUD.show(message)
    }
    
    func didRecivedCartItems(_ cartItems: [Products]) {
        if cartItems.count == 0 {
            self.setupEmptyViewTableView()
        } else {
            self.cartItems.removeAll()
            self.cartItems = cartItems
            self.setupCartDetails()
            self.tableView.reloadData()
        }
    }
}
