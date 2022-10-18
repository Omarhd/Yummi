//
//  LocationModel.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 18/10/2022.
//

import Foundation

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let placeName: String
}

let mocData = [Location(latitude: 15.5888852, longitude: 32.5243864, placeName: "KH 2"),
               Location(latitude: 15.5888852, longitude: 32.5243864, placeName: "KH 2"),
               Location(latitude: 15.5888852, longitude: 32.5243864, placeName: "KH 2"),
               Location(latitude: 15.5888852, longitude: 32.5243864, placeName: "KH 2"),
               Location(latitude: 15.5888852, longitude: 32.5243864, placeName: "KH 2"),
               Location(latitude: 15.5888852, longitude: 32.5243864, placeName: "KH 2"),
               Location(latitude: 15.5888852, longitude: 32.5243864, placeName: "KH 2"),
               Location(latitude: 15.5888852, longitude: 32.5243864, placeName: "KH 2"),
               Location(latitude: 15.5888852, longitude: 32.5243864, placeName: "KH 2"),]
