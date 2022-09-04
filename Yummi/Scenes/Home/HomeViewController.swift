//
//  ViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    var categories: [DishCategory] = [
        .init(id: "1", name: "Hello", image: "https://images.unsplash.com/photo-1602253057119-44d745d9b860?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGlzaHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
        .init(id: "1", name: "Hello", image: "https://images.unsplash.com/photo-1602253057119-44d745d9b860?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGlzaHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
        .init(id: "1", name: "Hello", image: "https://images.unsplash.com/photo-1602253057119-44d745d9b860?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGlzaHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
        .init(id: "1", name: "Hello", image: "https://images.unsplash.com/photo-1602253057119-44d745d9b860?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGlzaHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60")]
    
    var dishs: [Dish] = [
        .init(id: "1", title: "Hi there", image: "https://images.unsplash.com/photo-1602253057119-44d745d9b860?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGlzaHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60", calories: 32.22122, description: "any type of food"),
        .init(id: "1", title: "Hi there", image: "https://images.unsplash.com/photo-1602253057119-44d745d9b860?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGlzaHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60", calories: 32.22122, description: "any type of food"),
        .init(id: "1", title: "Hi there", image: "https://images.unsplash.com/photo-1602253057119-44d745d9b860?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGlzaHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60", calories: 32.22122, description: "any type of food"),
        .init(id: "1", title: "Hi there", image: "https://images.unsplash.com/photo-1602253057119-44d745d9b860?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGlzaHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60", calories: 32.22122, description: "any type of food"),
        .init(id: "1", title: "Hi there", image: "https://images.unsplash.com/photo-1602253057119-44d745d9b860?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGlzaHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60", calories: 32.22122, description: "any type of food"),
        .init(id: "1", title: "Hi there", image: "https://images.unsplash.com/photo-1602253057119-44d745d9b860?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZGlzaHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60", calories: 32.22122, description: "any type of food")]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        registerNibs()
    }
    
    private func registerNibs() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifire)
        
        popularCollectionView.register(UINib(nibName: PopularCollectionViewCell.identifire, bundle: nil), forCellWithReuseIdentifier: PopularCollectionViewCell.identifire)

    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView:
            return categories.count
        case popularCollectionView:
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
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let index = indexPath.row
        let dish = dishs[index]
        
        let identifier = "\(index)" as NSString

        return UIContextMenuConfiguration(
        identifier: identifier, previewProvider: nil) { _ in
          // 3
          let mapAction = UIAction(title: "View map",
                                   image: UIImage(systemName: "map")) { _ in
//                                    self.showMap(vacationSpot: dish)
          }
          
          // 4
          let shareAction = UIAction(
            title: "Share",
            image: UIImage(systemName: "square.and.arrow.up")) { _ in
//              VacationSharer.share(vacationSpot: vacationSpot, in: self)
          }
          
          // 5
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
            guard let identifier = configuration.identifier as? String,
              let index = Int(identifier),
              let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0))
                as? PopularCollectionViewCell
              else {
                return nil
            }
            return UITargetedPreview(view: cell.dishIamge)
            
        default: return nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        guard
          let identifier = configuration.identifier as? String,
          let index = Int(identifier)
          else {
            return
        }
        
        // 2
        let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0))
        
        // 3
        animator.addCompletion {
          self.performSegue(withIdentifier: "showSpotInfoViewController",
                            sender: cell)
        }
    }
}
