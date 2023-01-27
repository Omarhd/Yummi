//
//  HomeSkeletonViewExtension.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 25/01/2023.
//

import UIKit
import SkeletonView

extension HomeViewController: SkeletonCollectionViewDataSource {
    
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
    
    func showSkeletonAnimationView() {
        
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
    
    func stopSkeletonAnimationView() {
        
        self.storysCollectionView.stopSkeletonAnimation()
        self.storysCollectionView.hideSkeleton()
        
        self.categoryCollectionView.stopSkeletonAnimation()
        self.categoryCollectionView.hideSkeleton()
        
        self.popularCollectionView.stopSkeletonAnimation()
        self.popularCollectionView.hideSkeleton()
        
        self.chefCollectionView.stopSkeletonAnimation()
        self.chefCollectionView.hideSkeleton()
    }
    
}
