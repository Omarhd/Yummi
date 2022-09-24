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
    var itemsCount: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI(with: self.dish)

    }
   
    @IBAction func stepper(_ sender: UIStepper) {
        self.dishCountLabel.text = Int(sender.value).description
        self.itemsCount = Int(sender.value)
        
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
        item.qt = Int64(self.self.itemsCount)
        
        do {
            try self.context.save()
            showSuccessMessage(title: "Added", body: "Success added item to Cart")
        } catch {
            showErrorMessage(title: "Error", body: "can't added item to Cart")
        }

        cartButton.setImage(UIImage(systemName: "bag.fill"), for: .normal)
    }
    
    @IBAction func cartAction(_ sender: Any) {
        
        let detailsController =  CartViewController.instantiate(storyBoardName: "Cart")
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
}
