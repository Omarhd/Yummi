//
//  DishesDetailsViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 04/09/2022.
//

import UIKit
import Kingfisher
import Instructions

class DishesDetailsViewController: UIViewController {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishTitleLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    @IBOutlet weak var dishCaloriesLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var dishCountLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    // MARK:- refrence to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let coachMarksController = CoachMarksController()

    var dish: Popular!
    var itemPrice: Int!
    var itemsCount: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI(with: self.dish)

        self.coachMarksController.dataSource = self
        self.coachMarksController.delegate = self
        
        let skipView = CoachMarkSkipDefaultView()
        skipView.setTitle("Skip", for: .normal)
        self.coachMarksController.skipView = skipView
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !AppManager.getUserSeenAppInstructionForDishDetails() {
            self.coachMarksController.start(in: .viewController(self))
           }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.coachMarksController.stop(immediately: true)
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
            AlertMessages().showSuccessMessage(title: "Added", body: "Success added item to Cart")
        } catch {
            AlertMessages().showErrorMessage(title: "Error", body: "can't added item to Cart")
        }
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
