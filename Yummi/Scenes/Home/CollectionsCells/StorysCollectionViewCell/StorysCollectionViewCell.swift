//
//  StorysCollectionViewCell.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 16/12/2022.
//

import UIKit

class StorysCollectionViewCell: UICollectionViewCell {

    static let identifire = String(describing: StorysCollectionViewCell.self)

    @IBOutlet weak var image: RoundedImages!
    @IBOutlet weak var userName: UILabel!
   
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    func setupUI(with dish: Popular) {
        userName.text = dish.name
        activityIndicator.startAnimating()
        image.kf.setImage(with: dish.image.asURL)
        activityIndicator.stopAnimating()
    }
}
