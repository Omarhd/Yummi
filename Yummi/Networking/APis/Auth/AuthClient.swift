//
//  AuthClient.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import Foundation
import UIKit

class AuthAPIServices: APIClient {
    internal let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    func login(prameters: UserRequest,
               completion: @escaping (Result<UserResponse, DataLayerError<ErrorModel>>) -> Void)  {
        
        guard let request = AuthenticationFeed.auth.postRequest(parameters: prameters, headers: []) else { return }
        
        fetchHandler(with: request, decode: { (json) -> UserResponse? in
            guard let result = json as? UserResponse else { return nil }
            return result
        }, completion: completion)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}
