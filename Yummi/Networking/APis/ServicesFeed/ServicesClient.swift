//
//  ServicesClient.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 21/09/2022.
//

import Foundation
import UIKit

class APIServices: APIClient {
    internal let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    func getDishes(completion: @escaping (Result<BaseCategoriesResponse, DataLayerError<ErrorModel>>) -> Void)  {
        guard let request = APIServicesFeed.allCategories.getRequest(parameters: [:], headers: [
    
        ]) else { return }
        
        fetchHandler(with: request, decode: { (json) -> BaseCategoriesResponse? in
            guard let result = json as? BaseCategoriesResponse else { return nil }
            return result
        }, completion: completion)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
}
