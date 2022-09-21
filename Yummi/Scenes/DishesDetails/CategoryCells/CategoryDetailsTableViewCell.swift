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
    @IBOutlet weak var activitIndecator: UIActivityIndicatorView!
 
    func setupUI(with category: Category) {
        titleLabel.text = category.title
        descriptionLabel.text = category.title
        
        activitIndecator.startAnimating()
        categoryImageView.kf.setImage(with: category.image.asURL)
        activitIndecator.stopAnimating()

    }
}
