//
//  CartPresenter.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 18/11/2022.
//

import UIKit
import CoreData

protocol CartViewDelegate: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func showErrorMessage(_ message: String)
    func didRecivedCartItems(_ cartItems: [Products])
}

class CartPresenter {
    
    weak fileprivate var cartView: CartViewDelegate?
    
    // MARK:- refrence to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func attachView(_ view: CartViewDelegate) {
        self.cartView = view
    }
    
    func detachView() {
        self.cartView = nil
    }
    
    func fetchProducts() {
        do {
            let items = try context.fetch(Products.fetchRequest())
            self.cartView?.didRecivedCartItems(items)
        } catch {
            
        }
    }
}
