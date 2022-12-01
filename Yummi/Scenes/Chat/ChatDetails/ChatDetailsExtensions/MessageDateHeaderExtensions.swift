//
//  MessageDateHeaderExtensions.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 01/12/2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import SwiftMessages
import IQKeyboardManagerSwift
import SnapKit


class MessageDateReusableView: MessageReusableView {
   
    var label: PaddingLabel!

    override init (frame : CGRect) {
        super.init(frame : frame)
        self.backgroundColor = .none

        label = PaddingLabel()
        label.backgroundColor = .clear
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 11)
        label.paddingLeft = 5
        label.paddingRight = 5
        self.addSubview(label)

        label.clipsToBounds = true
        label.layer.cornerRadius = 3
        
        label.snp.makeConstraints { (make) in
            make.center.equalTo(self.center)
            make.top.equalTo(self.snp.top).offset(2)
            make.bottom.equalTo(self.snp.bottom).offset(-2)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PaddingLabel: UILabel {

    var textEdgeInsets = UIEdgeInsets.zero {
         didSet { invalidateIntrinsicContentSize() }
     }
     
     open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
         let insetRect = bounds.inset(by: textEdgeInsets)
         let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
         let invertedInsets = UIEdgeInsets(top: -textEdgeInsets.top, left: -textEdgeInsets.left, bottom: -textEdgeInsets.bottom, right: -textEdgeInsets.right)
         return textRect.inset(by: invertedInsets)
     }
     
     override func drawText(in rect: CGRect) {
         super.drawText(in: rect.inset(by: textEdgeInsets))
     }
     
     
     var paddingLeft: CGFloat {
         set { textEdgeInsets.left = newValue }
         get { return textEdgeInsets.left }
     }
     
     var paddingRight: CGFloat {
         set { textEdgeInsets.right = newValue }
         get { return textEdgeInsets.right }
     }
     
     var paddingTop: CGFloat {
         set { textEdgeInsets.top = newValue }
         get { return textEdgeInsets.top }
     }
     
     var paddingBottom: CGFloat {
         set { textEdgeInsets.bottom = newValue }
         get { return textEdgeInsets.bottom }
     }
 }



extension Date {
    func isInSameDayOf(date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    func isToday() -> Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    func wasYesterday() -> Bool {
        return Calendar.current.isDateInYesterday(self)
    }
}
