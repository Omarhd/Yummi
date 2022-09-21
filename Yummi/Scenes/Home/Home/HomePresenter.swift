//
//  HomePresenter.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 21/09/2022.
//

import Foundation
import UIKit

protocol CategoriesViewDelegate: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func showErrorMessage(_ message: String)
    func didRecivedDishes(_ categories: BaseCategoriesResponse)
}

extension CategoriesViewDelegate {
    
}

class HomePresenter {
    
    fileprivate let apiServices: APIServices
    weak fileprivate var categoriesView: CategoriesViewDelegate?
    
    init(apiServices: APIServices) {
        self.apiServices = apiServices
    }
    
    func attachView(_ view: CategoriesViewDelegate) {
        self.categoriesView = view
    }
    
    func detachView() {
        self.categoriesView = nil
    }
    
    func getAllCategories() {
        
        self.categoriesView?.startLoading()
        self.apiServices.getDishes { Result in
            switch Result {
            case .success(let dishes):
                self.categoriesView?.didRecivedDishes(dishes)
                self.categoriesView?.stopLoading()
            case .failure(let error):
                var messageToShow = ""
                switch error {
                case .backend(let backendError):
                    messageToShow = backendError.message!
                case .network(let message):
                    messageToShow = message
                case .parsing(let errorDesc, let statusCode):
                    messageToShow = "Issue in data try aganin later".localizable()
                    print("status Code \(statusCode)")
                    print("Error Dec \(errorDesc)")
                }
                self.categoriesView?.stopLoading()
                self.categoriesView?.showErrorMessage(messageToShow)
            }
        }
    }
}
