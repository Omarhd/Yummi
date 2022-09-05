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
    var itemCount: Int = 1
    var itemPrice: Int = 2000
    var cart: [Dish] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI(with: self.dish)
        setupCartUI()
    }
    @IBAction func stepper(_ sender: UIStepper) {
        self.dishCountLabel.text = Int(sender.value).description
        itemPrice = self.itemPrice * Int(sender.value)
        
        self.dishPriceLabel.text = "\(itemPrice)"
        itemPrice = 2000
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
    }
    
    private func setupCartUI() {
        if cart.count == 0 {
            cartButton.setImage(UIImage(systemName: "bag.fill"), for: .normal)
        } else {
            cartButton.setImage(UIImage(systemName: "bag.badge.minus"), for: .normal)
        }
    }
}
