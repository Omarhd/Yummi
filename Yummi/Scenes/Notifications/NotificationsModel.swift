//
//  NotificationsModel.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 30/10/2022.
//

import UIKit

import UIKit

enum Weapon {
  case blowgun, ninjaStar, fire, sword, smoke

  var image: UIImage {
    switch self {
    case .blowgun:
      return UIImage(systemName: "bag")!
    case .fire:
      return UIImage(systemName: "fire")!
    case .ninjaStar:
      return UIImage(systemName: "gear")!
    case .smoke:
      return UIImage(systemName: "circle")!
    case .sword:
      return UIImage(systemName: "square")!
    }
  }
}

class Notifications {
  let name: String
  let description: String
  let iconName: String
  let weapon: Weapon

  init(name: String, description: String, iconName: String, weapon: Weapon) {
    self.name = name
    self.description = description
    self.iconName = iconName
    self.weapon = weapon
  }

  var icon: UIImage? {
    return UIImage(named: iconName)
  }
}
