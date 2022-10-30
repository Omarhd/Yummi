//
//  NotificationDetailsViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 30/10/2022.
//

import UIKit

class NotificationDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var weaponImageView: UIImageView!

    var notification: Notifications? {
      didSet {
        refreshUI()
      }
    }

    private func refreshUI() {
      loadViewIfNeeded()
      nameLabel.text = notification?.name
      descriptionLabel.text = notification?.description
      iconImageView.image = notification?.icon
      weaponImageView.image = notification?.weapon.image
    }
  }

 
extension NotificationDetailsViewController: MonsterSelectionDelegate {
    func monsterSelected(_ newMonster: Notifications) {
        notification = newMonster
    }
}
