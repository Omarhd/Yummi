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
       
        self.cartView?.startLoading()
        
        do {
            let items = try context.fetch(Products.fetchRequest())
            self.cartView?.didRecivedCartItems(items)
            self.cartView?.stopLoading()
       
        } catch {
            
            self.cartView?.stopLoading()
            
        }
        self.cartView?.stopLoading()
    }
    
    func deleteItem(item: Products) {
       
        self.cartView?.startLoading()
        self.context.delete(item)
       
        do {
            try self.context.save()
            Messages().showSuccessMessage(title: "Done", body: "Removed item.")
            self.cartView?.stopLoading()

        } catch {
            Messages().showErrorMessage(title: "Error", body: "Can't Remove items for now.")
            self.cartView?.stopLoading()

        }
        
        fetchProducts()
    }
    
    
    func emptyAllCart() {
      
        self.cartView?.startLoading()
      
        do {
            let items = try context.fetch(Products.fetchRequest())
            self.cartView?.didRecivedCartItems(items)
            
            for object in items {
                self.context.delete(object)
            }
            
        } catch {
            self.cartView?.stopLoading()
        }
        
        do {
            try self.context.save()
            Messages().showSuccessMessage(title: "Done", body: "Cart is Clear.")
            self.cartView?.stopLoading()

        } catch {
            Messages().showErrorMessage(title: "Error", body: "Can't Remove items for now.")
            self.cartView?.stopLoading()
        }
        
        fetchProducts()
    }
}
