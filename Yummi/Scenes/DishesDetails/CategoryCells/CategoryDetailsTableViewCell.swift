//
//  CategoryDetailsTableViewCell.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 05/09/2022.
//

import UIKit
import Kingfisher

class CategoryDetailsTableViewCell: UITableViewCell {

    static let identifire = String(describing: CategoryDetailsTableViewCell.self)

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setupUI(with category: DishCategory) {
        categoryImageView.kf.setImage(with: category.image.asURL)
        titleLabel.text = category.name
        descriptionLabel.text = "Mock text for testing"
    }
}
