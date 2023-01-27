//
//  CartViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 04/09/2022.
//

import UIKit
import ProgressHUD
import LocalAuthentication
import SwiftMessages

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyCartView: UIView!
    @IBOutlet weak var detailsView: CardView!
    
    @IBOutlet weak var itemsCountLabel: UILabel!
    @IBOutlet weak var deliveryChargeLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
        
    fileprivate let cartPresenter = CartPresenter()
    var dish: Popular!

    var cartItems: [Products] = []
    var totalPrice: String?
    var selectedCells:[Int] = []

    let touchMe = BiometricIDAuth()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.cartPresenter.attachView(self)
       
        cartPresenter.fetchProducts()
        registerNibs()
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: CartItemsTableViewCell.identifire, bundle: nil), forCellReuseIdentifier: CartItemsTableViewCell.identifire)
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    @IBAction func doneAction(_ sender: Any) {
        let auth = UserAuthViewController.instantiate(storyBoardName: "Auth")
        auth.modalPresentationStyle = .formSheet
        self.present(auth, animated: true, completion: nil)
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
    
    @IBAction func edtiCartAction(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing) ? "Done" : "Edit"
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
        cell.accessoryType = self.selectedCells.contains(indexPath.row) ? .checkmark : .disclosureIndicator
        
        
        let total = Double(self.cartItems.count) * cartItems[indexPath.row].price
        self.totalPrice = "\(total)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailsController =  CartItemDetailViewController()
        detailsController.cartItems = self.cartItems[indexPath.row]

        self.navigationController?.pushViewController(detailsController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to
                   destinationIndexPath: IndexPath) {
        let movedobjTemp = cartItems[sourceIndexPath.item]
        cartItems.remove(at: sourceIndexPath.item)
        cartItems.insert (movedobjTemp, at: destinationIndexPath.item)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            cartItems.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    func deSelectCell(tableView: UITableView, indexPath: IndexPath) {
        
    }
    
    func selectCell(tableView: UITableView, indexPath: IndexPath) {
        
    }

    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let index = indexPath.row
        let identifier = "\(index)" as NSString
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemsTableViewCell.identifire, for: indexPath) as! CartItemsTableViewCell
        cell.setupUI(with: self.cartItems[indexPath.row])
        
        return UIContextMenuConfiguration(
            identifier: identifier, previewProvider: nil) { _ in
                
                let shareAction = UIAction(title: "Share",
                                         image: UIImage(systemName: "square.and.arrow.up")) { _ in
                    
                    self.doShare(shareItems: [cell.contentView.asImage()])
                }
                
                let deleteAction = UIAction(
                    title: "Remove",
                    image: UIImage(systemName: "trash"),
                    attributes: .destructive,
                    state: .mixed) { _ in
                        let item = self.cartItems[indexPath.row]
                        self.cartPresenter.deleteItem(item: item)
                    }
                
                var selectionTitle: String = "Select"
                var selectionImage: String = "checkmark.circle"
                
                if self.selectedCells.contains(index) {
                    selectionTitle = "Unselect"
                    selectionImage = "circle"
                }
                
                let selectAction = UIAction(
                    title: selectionTitle,
                    image: UIImage(systemName: selectionImage),
                    state: .off) { _ in
                        if self.selectedCells.contains(index) {
                            let index = self.selectedCells.firstIndex(of: index)
                            self.selectedCells.remove(at: index!)
                        }else {
                            self.selectedCells.append(indexPath.row)
                        }
                        self.tableView.reloadData()
                    }
                
                return UIMenu(title: "Options", image: nil,
                              children: [deleteAction, shareAction, selectAction])
            }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Remove") { action, view, complection in
            let item = self.cartItems[indexPath.row]
            self.cartPresenter.deleteItem(item: item)
        }
        
        return UISwipeActionsConfiguration(actions: [action])
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
