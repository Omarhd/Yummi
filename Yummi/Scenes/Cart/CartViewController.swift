//
//  CartViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 04/09/2022.
//

import UIKit

class CartViewController: UIViewController {

    var cartItem: [Dish] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(cartItem.count)
    }
}
