//
//  UIViews.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: Double {
        get { return Double(self.layer.cornerRadius) }
        set { self.layer.cornerRadius = CGFloat(newValue) }
    }
    
    @IBInspectable var borderWidth: Double {
        get { return Double(self.layer.borderWidth) }
        set { self.layer.borderWidth = CGFloat(newValue) }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get { return UIColor(cgColor: self.layer.borderColor!) }
        set { self.layer.borderColor = newValue?.cgColor }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get { return UIColor(cgColor: self.layer.shadowColor!) }
        set { self.layer.shadowColor = newValue?.cgColor }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get { return self.layer.shadowOpacity }
        set { self.layer.shadowOpacity = newValue }
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
        layer.shadowRadius = 8
        cornerRadius = 8
    }
}

class RoundedImages: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initailSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initailSetup()
    }
    
    private func initailSetup() {
        layer.cornerRadius = frame.height / 2
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
