//
//  StringURLs.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 04/09/2022.
//

import Foundation

extension String {
    var asURL: URL? {
        return URL(string: self)
    }
}
