//
//  ViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import UIKit
import ProgressHUD

class HomeViewController: UIViewController {
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var chefCollectionView: UICollectionView!
    
    fileprivate let homePresenter = HomePresenter(apiServices: APIServices())
    fileprivate var allCategories: BaseCategoriesResponse?
    
    private let refreshControl = UIRefreshControl()
    var isLoadingStarted = true

    
    var categories: [Category] = []
    var dishs: [Popular] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homePresenter.attachView(self)
        self.homePresenter.getAllCategories()
        
        registerNibs()
    }
    
    private func registerNibs() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifire)
        popularCollectionView.register(UINib(nibName: PopularCollectionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: PopularCollectionViewCell.identifire)
        chefCollectionView.register(UINib(nibName: ChefCollectionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: ChefCollectionViewCell.identifire)
        
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
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
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifire, for: indexPath) as! CategoryCollectionViewCell
            cell.setupUI(with: categories[indexPath.row])
            
            return cell
            
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifire, for: indexPath) as! PopularCollectionViewCell
            cell.setupUI(with: dishs[indexPath.row])
            
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
                    //                                    self.showMap(vacationSpot: dish)
                }
                
                let shareAction = UIAction(
                    title: "Add to Cart",
                    image: UIImage(systemName: "bag.fill.badge.plus")) { _ in
                       
                    }
                
                return UIMenu(title: "", image: nil,
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
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.show()
    }
    
    func stopLoading() {
        ProgressHUD.dismiss()
    }
    
    func showErrorMessage(_ message: String) {
        ProgressHUD.showError(message)
    }
    
    func didRecivedDishes(_ categories: BaseCategoriesResponse) {
        self.allCategories = categories
        self.categories = categories.data.categories
        self.dishs = categories.data.populars

        reloadCollectionsData()
        print(categories)
    }
    
    fileprivate func reloadCollectionsData() {
        self.categoryCollectionView.reloadData()
        self.popularCollectionView.reloadData()
        self.chefCollectionView.reloadData()
    }
}
