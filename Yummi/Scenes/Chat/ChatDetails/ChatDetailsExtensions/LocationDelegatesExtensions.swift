//
//  LocationDelegatesExtensions.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 07/12/2022.
//

import Foundation

extension ChatDetailsViewController:  locationSelectionDelegate {
    
    func didSelectLocation(lat: Double, long: Double, name: String) {
        print(lat, long)
    }
}
