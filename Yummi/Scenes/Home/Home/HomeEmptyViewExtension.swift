//
//  HomeEmptyViewExtension.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 25/01/2023.
//

import UIKit

class MyCustomView: UIView {
    
    var label: UILabel = UILabel()
    var myNames = ["dipen","laxu","anis","aakash","santosh","raaa","ggdds","house"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCustomView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomView() {
        label.frame = CGRectMake(50, 10, 200, 100)
        label.backgroundColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.text = "test label"
        label.isHidden = true
        self.addSubview(label)
        
        var btn: UIButton = UIButton()
        btn.frame = CGRectMake(50, 120, 200, 100)
        btn.backgroundColor = UIColor.red
        btn.setTitle("button", for: .normal)
        btn.addTarget(self, action: Selector("changeLabel"), for: UIControl.Event.touchUpInside)
        self.addSubview(btn)
        
        var txtField : UITextField = UITextField()
        txtField.frame = CGRectMake(50, 250, 100,50)
        txtField.backgroundColor = UIColor.gray
        self.addSubview(txtField)
    }
}
