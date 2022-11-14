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

let mocData = [Location(latitude: 15.5988852, longitude: 32.5943864, placeName: "KH 1"),
               Location(latitude: 15.5888852, longitude: 32.5843864, placeName: "KH 2"),
               Location(latitude: 15.5788852, longitude: 32.5743864, placeName: "KH 3"),
               Location(latitude: 15.5688852, longitude: 32.5643864, placeName: "KH 4"),
               Location(latitude: 15.5588852, longitude: 32.5543864, placeName: "KH 5"),
               Location(latitude: 15.5488852, longitude: 32.5443864, placeName: "KH 6"),
               Location(latitude: 15.5388852, longitude: 32.5343864, placeName: "KH 7"),
               Location(latitude: 15.5288852, longitude: 32.5243864, placeName: "KH 8"),
               Location(latitude: 15.5188852, longitude: 32.5143864, placeName: "KH 9"),]
