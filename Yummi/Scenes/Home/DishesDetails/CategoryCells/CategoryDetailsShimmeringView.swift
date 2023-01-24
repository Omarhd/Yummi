//
//  CategoryDetailsShimmeringView.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 18/01/2023.
//

import UIView_Shimmer

extension CategoryDetailsTableViewCell: ShimmeringViewProtocol {
    
    var shimmeringAnimatedItems: [UIView] {
        [
            categoryImageView,
            titleLabel,
            descriptionLabel
        ]
    }
}
