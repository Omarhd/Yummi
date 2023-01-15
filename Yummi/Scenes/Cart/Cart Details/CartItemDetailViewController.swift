//
//  CartItemDetailViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 15/01/2023.
//

import UIKit

class CartItemDetailViewController: UIViewController {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCalories: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    
    
    var cartItems: Products!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.itemImage.kf.setImage(with: cartItems.img?.asURL)
        self.itemName.text = self.cartItems.name
        self.itemPrice.text = self.cartItems.price.description
        self.itemCalories.text = self.cartItems.price.description
        self.itemDescription.text = self.cartItems.details

    }
}
