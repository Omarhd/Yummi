//
//  CartItemsTableViewCell.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 05/09/2022.
//

import UIKit

class CartItemsTableViewCell: UITableViewCell {

    static let identifire = String(describing: CartItemsTableViewCell.self)

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    func setupUI(with item: Products) {
        itemImageView.kf.setImage(with: item.img?.asURL)
        titleLabel.text = item.name
        descriptionLabel.text = item.details
        priceLabel.text = "\(item.price)"
    }
}
