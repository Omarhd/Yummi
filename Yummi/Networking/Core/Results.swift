//
//  Core.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}

enum DataLayerError<E: Error & Decodable>: Error  {
    case backend (E)
    case network(String)
    case parsing(String, Int)
}
