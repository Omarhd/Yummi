//
//  UIViews.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius}
        set { self.layer.cornerRadius = newValue}
    }
}

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initailSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initailSetup()
    }
    
    private func initailSetup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 8
        layer.shadowOpacity = 0.1
        cornerRadius = 8
    }
}
