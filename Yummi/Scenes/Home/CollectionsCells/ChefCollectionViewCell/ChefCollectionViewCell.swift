//
//  ChefCollectionViewCell.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 04/09/2022.
//

import UIKit
import Kingfisher

class ChefCollectionViewCell: UICollectionViewCell {

    static let identifire = String(describing: ChefCollectionViewCell.self)

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    func setupUI(with dish: Dish) {
        titleLabel.text = dish.title
        descriptionLabel.text = dish.description
        caloriesLabel.text = dish.formattedCalories
        
        activityIndicator.startAnimating()
        imageView.kf.setImage(with: dish.image.asURL)
        activityIndicator.startAnimating()
    }
}
