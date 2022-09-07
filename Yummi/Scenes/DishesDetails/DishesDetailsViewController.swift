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
    
    var dish: Dish!
    var itemPrice: Double!
    var cart: [Dish] = []
    
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
        itemPrice = self.itemPrice * Double(sender.value)
        
        if let finalPrice = itemPrice {
            self.dishPriceLabel.text = "\(finalPrice)"
        }
      
        itemPrice = dish.price
    }
    
    @IBAction func addItemToCart(_ sender: Any) {
        self.cart.append(dish)
        cartButton.setImage(UIImage(systemName: "bag.fill"), for: .normal)
    }
    
    @IBAction func cartAction(_ sender: Any) {
        let detailsController =  CartViewController.instantiate(storyBoardName: "Cart")
        detailsController.cartItem = [dish]
        
        navigationController?.pushViewController(detailsController, animated: true)

    }
    
    private func setupUI(with dish: Dish) {
        dishImageView.kf.setImage(with: dish.image.asURL)
        dishTitleLabel.text = dish.title
        dishDescriptionLabel.text = dish.description
        dishCaloriesLabel.text = dish.formattedCalories
        dishPriceLabel.text = dish.formattedPrice
        
        self.itemPrice = dish.price
    }
    
    private func setupCartUI() {
        if cart.count == 0 {
            cartButton.setImage(UIImage(systemName: "bag.circle.fill"), for: .normal)
        } else {
            cartButton.setImage(UIImage(systemName: "bag.badge.minus"), for: .normal)
        }
    }
}
