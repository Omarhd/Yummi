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
    
    
    func setupUI(with item: Popular) {
        itemImageView.kf.setImage(with: item.image.asURL)
        titleLabel.text = item.name
        descriptionLabel.text = item.popularDescription
        priceLabel.text = "\(item.calories)"
    }
}
