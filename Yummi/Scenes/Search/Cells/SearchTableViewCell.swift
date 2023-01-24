//
//  SearchTableViewCell.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 24/01/2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifire = String(describing: SearchTableViewCell.self)

    @IBOutlet weak var shapeName: UILabel!
    @IBOutlet weak var shapeImage: UIImageView!
    
    func setup(_ shape: Shape) {
        self.shapeName.text = shape.name
        self.shapeImage.image =  UIImage(systemName: shape.imageName)
    }
}
