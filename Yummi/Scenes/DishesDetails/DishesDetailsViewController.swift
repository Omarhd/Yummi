//
//  DishesDetailsViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 04/09/2022.
//

import UIKit
import Kingfisher

class DishesDetailsViewController: UIViewController {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishTitleLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    @IBOutlet weak var dishCaloriesLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var dishCountLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var cartButton: UIButton!
    
    // MARK:- refrence to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var dish: Popular!
    var itemPrice: Int!
    var cart: [Popular] = []
    
    var formattedPrice: String! {
        return String(format: "%.2f", String(itemPrice))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI(with: self.dish)
        setupCartUI()
    }
    @IBAction func stepper(_ sender: UIStepper) {
        self.dishCountLabel.text = Int(sender.value).description
        itemPrice = self.dish.calories * Int(sender.value)
        
        if let finalPrice = itemPrice {
            self.dishPriceLabel.text = "\(finalPrice)"
        }
      
        itemPrice = dish.calories
    }
    
    @IBAction func addItemToCart(_ sender: Any) {
        
        let item = Products(context: self.context)
        
        item.name = self.dish.name
        item.details = self.dish.popularDescription
        item.price = Double(self.dish.calories)
        item.img = self.dish.image
        item.qt = 1
        
        do {
            try self.context.save()
        } catch {
            
        }

        cartButton.setImage(UIImage(systemName: "bag.fill"), for: .normal)
    }
    
    @IBAction func cartAction(_ sender: Any) {
        let detailsController =  CartViewController.instantiate(storyBoardName: "Cart")
//        detailsController.cartItem = [Popular]
        
        navigationController?.pushViewController(detailsController, animated: true)

    }
    
    private func setupUI(with dish: Popular) {
        dishImageView.kf.setImage(with: dish.image.asURL)
        dishTitleLabel.text = dish.name
        dishDescriptionLabel.text = dish.popularDescription
        dishCaloriesLabel.text = "\(dish.calories)"
        dishPriceLabel.text = "\(dish.calories)"
        
        self.itemPrice = dish.calories
    }
    
    private func setupCartUI() {
        if cart.count == 0 {
            cartButton.setImage(UIImage(systemName: "bag.circle.fill"), for: .normal)
        } else {
            cartButton.setImage(UIImage(systemName: "bag.badge.minus"), for: .normal)
        }
    }
}
