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
}
