//
//  SlideCollectionViewCell.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    
    static let identifire = String(describing: SlideCollectionViewCell.self)
    
    @IBOutlet weak var SlideImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setupView(with Slide: OnBoardingSlide) {
        self.SlideImageView.image = Slide.image
        self.titleLabel.text = Slide.title
        self.descriptionLabel.text = Slide.description
    }
}
