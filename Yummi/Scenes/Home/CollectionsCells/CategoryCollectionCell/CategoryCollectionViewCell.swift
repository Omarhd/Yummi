//
//  CategoryCollectionViewCell.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {

    static let identifire = String(describing: CategoryCollectionViewCell.self)

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    func setupUI(with category: DishCategory) {
        categoryTitle.text = category.name
        
        activityIndicator.startAnimating()
        categoryImage.kf.setImage(with: category.image.asURL)
        activityIndicator.startAnimating()

    }
}
