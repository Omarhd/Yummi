//
//  PopularCollectionViewCell.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 04/09/2022.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
   
    static let identifire = String(describing: PopularCollectionViewCell.self)

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dishIamge: UIImageView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func setupUI(with dish: Popular) {
        titleLabel.text = dish.name
        caloriesLabel.text = "\(dish.calories)"
        descriptionLabel.text = dish.popularDescription
        priceLabel.text = "\(dish.calories)"
        
        activityIndicator.startAnimating()
        dishIamge.kf.setImage(with: dish.image.asURL)
        activityIndicator.stopAnimating()

    }
}
