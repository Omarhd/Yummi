//
//  Share.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 12/01/2023.
//

import Foundation
import UIKit

extension UIViewController {
    
    func doShare(shareItems: [Any]) {
        let viewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        viewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        self.present(viewController, animated: true, completion: nil)
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return ""
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return URL.init(string: "")!
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return ""
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, thumbnailImageForActivityType activityType: UIActivity.ActivityType?, suggestedSize size: CGSize) -> UIImage? {
        return nil
    }
    
}
