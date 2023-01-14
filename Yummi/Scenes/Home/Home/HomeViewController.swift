//
//  ViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import UIKit
import ProgressHUD
import SkeletonView
import Instructions

class HomeViewController: UIViewController {
    
    @IBOutlet weak var storysCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var chefCollectionView: UICollectionView!
    
    fileprivate let homePresenter = HomePresenter(apiServices: APIServices())
    fileprivate var allCategories: BaseCategoriesResponse?
    
    let coachMarksController = CoachMarksController()
    
    var isLoadingStarted = true
    
    // MARK:- refrence to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categories: [Category] = []
    var dishs: [Popular] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utility().doLocalAuthentication()
        
        updateUserInterface()
        homePresenter.attachView(self)
        self.homePresenter.getAllCategories()
        
        self.coachMarksController.dataSource = self
        self.coachMarksController.delegate = self
        
        let skipView = CoachMarkSkipDefaultView()
        skipView.setTitle("Skip", for: .normal)
        self.coachMarksController.skipView = skipView
        
        registerNibs()
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        gesture.direction = .down
        view.addGestureRecognizer(gesture)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !AppManager.getUserSeenAppInstructionForHome() {
            self.coachMarksController.start(in: .viewController(self))
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.coachMarksController.stop(immediately: true)
    }
    
    @objc func handleSwipe() {
        self.homePresenter.getAllCategories()
    }
    
    private func registerNibs() {
        storysCollectionView.register(UINib(nibName: StorysCollectionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: StorysCollectionViewCell.identifire)
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifire)
        popularCollectionView.register(UINib(nibName: PopularCollectionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: PopularCollectionViewCell.identifire)
        chefCollectionView.register(UINib(nibName: ChefCollectionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: ChefCollectionViewCell.identifire)
        
    }
    
    fileprivate func showSkeletonAnimationView() {
        
        storysCollectionView.isSkeletonable = true
        storysCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray),
                                                          animation: nil,
                                                          transition: .crossDissolve(0.25))
        
        categoryCollectionView.isSkeletonable = true
        categoryCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray),
                                                            animation: nil,
                                                            transition: .crossDissolve(0.25))
        
        popularCollectionView.isSkeletonable = true
        popularCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray),
                                                           animation: nil,
                                                           transition: .crossDissolve(0.25))
        
        chefCollectionView.isSkeletonable = true
        chefCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray),
                                                        animation: nil,
                                                        transition: .crossDissolve(0.25))
    }
    
    fileprivate func stopSkeletonAnimationView() {
        
        self.storysCollectionView.stopSkeletonAnimation()
        self.storysCollectionView.hideSkeleton()
        
        self.categoryCollectionView.stopSkeletonAnimation()
        self.categoryCollectionView.hideSkeleton()
        
        self.popularCollectionView.stopSkeletonAnimation()
        self.popularCollectionView.hideSkeleton()
        
        self.chefCollectionView.stopSkeletonAnimation()
        self.chefCollectionView.hideSkeleton()
    }
    
    fileprivate func presentLockScene() {
        let lockScene = BiometricsAuthViewController()
        lockScene.modalPresentationStyle = .overFullScreen
        self.present(lockScene, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        
        var identifire: String = ""
        
        switch skeletonView {
        case storysCollectionView:
            identifire = StorysCollectionViewCell.identifire
        case categoryCollectionView:
            identifire = CategoryCollectionViewCell.identifire
        case popularCollectionView:
            identifire = PopularCollectionViewCell.identifire
        case chefCollectionView:
            identifire = ChefCollectionViewCell.identifire
        default :
            break
        }
        return identifire
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case storysCollectionView:
            return categories.count
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
            return dishs.count
        case chefCollectionView:
            return dishs.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            
        case storysCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StorysCollectionViewCell.identifire, for: indexPath) as! StorysCollectionViewCell
            cell.setupUI(with: dishs[indexPath.row])
            
            return cell
            
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifire, for: indexPath) as! CategoryCollectionViewCell
            cell.setupUI(with: categories[indexPath.row])
            
            return cell
            
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifire, for: indexPath) as! PopularCollectionViewCell
            cell.setupUI(with: dishs[indexPath.row])
            
            cell.addToCartButton.tag = indexPath.row
            cell.addToCartButton.addTarget(self, action: #selector(addToCartFromCell), for: .touchUpInside)
            
            return cell
            
        case chefCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChefCollectionViewCell.identifire, for: indexPath) as! ChefCollectionViewCell
            cell.setupUI(with: dishs[indexPath.row])
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoryCollectionView:
            let detailsController =  CategoryDetailsViewController.instantiate(storyBoardName: "DishesDetails")
            detailsController.categories = self.categories
            
            navigationController?.pushViewController(detailsController, animated: true)
            
        case popularCollectionView:
            let detailsController =  DishesDetailsViewController.instantiate(storyBoardName: "DishesDetails")
            detailsController.dish = self.dishs[indexPath.row]
            
            navigationController?.pushViewController(detailsController, animated: true)
            
        case chefCollectionView:
            let detailsController =  DishesDetailsViewController.instantiate(storyBoardName: "DishesDetails")
            detailsController.dish = self.dishs[indexPath.row]
            
            navigationController?.pushViewController(detailsController, animated: true)
            
        default: break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let index = indexPath.row
        let dish = dishs[index]
        
        let identifier = "\(index)" as NSString
        
        return UIContextMenuConfiguration(
            identifier: identifier, previewProvider: nil) { _ in
                
                let mapAction = UIAction(title: "Share",
                                         image: UIImage(systemName: "square.and.arrow.up")) { _ in
                    
                    self.doShare(shareItems: [self.context])
                }
                
                let shareAction = UIAction(
                    title: "Add to Cart",
                    image: UIImage(systemName: "bag.fill.badge.plus")) { _ in
                        self.addToCart(dish: dish)
                    }
                
                return UIMenu(title: "Options", image: nil,
                              children: [mapAction, shareAction])
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        switch collectionView {
        case categoryCollectionView:
            guard let identifier = configuration.identifier as? String,
                  let index = Int(identifier),
                  let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0))
                    as? CategoryCollectionViewCell
            else {
                return nil
            }
            return UITargetedPreview(view: cell)
            
        case popularCollectionView:
            //            guard let identifier = configuration.identifier as? String,
            //                  let index = Int(identifier),
            //                  let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0))
            //                    as? PopularCollectionViewCell
            //            else {
            //                return nil
            //            }
            //            return UITargetedPreview(view: cell.dishIamge)
            return nil
        default: return nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        
        switch collectionView {
        case categoryCollectionView:
            return
        case popularCollectionView:
            guard let identifier = configuration.identifier as? String,
                  let index = Int(identifier)
            else {
                return
            }
            
            animator.addCompletion {
                let detailsController =  DishesDetailsViewController.instantiate(storyBoardName: "DishesDetails")
                detailsController.dish = self.dishs[index]
                
                self.navigationController?.pushViewController(detailsController, animated: true)
            }
        case chefCollectionView:
            return
            
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willCommitMenuWithAnimator animator: UIContextMenuInteractionCommitAnimating) {
        animator.addAnimations {
            self.show(DishesDetailsViewController(), sender: self)
        }
    }
}

extension HomeViewController: CategoriesViewDelegate {
    func startLoading() {
        showSkeletonAnimationView()
    }
    
    func stopLoading() {
        stopSkeletonAnimationView()
        
    }
    
    func showErrorMessage(_ message: String) {
        ProgressHUD.showError(message)
    }
    
    func didRecivedDishes(_ categories: BaseCategoriesResponse) {
        self.allCategories = categories
        self.categories = categories.data.categories
        self.dishs = categories.data.populars
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.reloadCollectionsData()
        }
        
    }
    
    fileprivate func reloadCollectionsData() {
        self.storysCollectionView.reloadData()
        self.categoryCollectionView.reloadData()
        self.popularCollectionView.reloadData()
        self.chefCollectionView.reloadData()
        
    }
    
    fileprivate func addToCart(dish: Popular) {
        let item = Products(context: self.context)
        
        item.name = dish.name
        item.details = dish.popularDescription
        item.price = Double(dish.calories)
        item.img = dish.image
        
        do {
            try self.context.save()
            Messages().showSuccessMessage(title: "Added", body: "Success added item to Cart")
        } catch {
            Messages().showErrorMessage(title: "Error", body: "can't added item to Cart")
        }
    }
    
    @objc fileprivate func addToCartFromCell(sender: UIButton) {
        let item = Products(context: self.context)
        
        item.name = self.dishs[sender.tag].name
        item.details = self.dishs[sender.tag].popularDescription
        item.price = Double(self.dishs[sender.tag].calories)
        item.img = self.dishs[sender.tag].image
        
        do {
            try self.context.save()
            Messages().showSuccessMessage(title: "Added", body: "Success added item to Cart")
        } catch {
            Messages().showErrorMessage(title: "Error", body: "can't added item to Cart")
        }
    }
}
