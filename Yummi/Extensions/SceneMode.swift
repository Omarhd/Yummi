//
//  SceneMode.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 12/09/2022.
//

import UIKit

enum Theme: String {
    case light, dark, system

    var uiInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return .unspecified
        }
    }
}
