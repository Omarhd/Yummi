//
//  OnBoardingViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 03/09/2022.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    
    var slides: [OnBoardingSlide] = []
    
    var currentPage = 0 {
        didSet {
            pageControll.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            OnBoardingSlide(title: "Delicious Dishes",
                            description: "Experience a variety of amazing dishes from different cultures around the world.",
                            image: #imageLiteral(resourceName: "slide2")),
            
            OnBoardingSlide(title: "World-Class Chefs",
                            description: "Our dishes are prepared by only the best.",
                            image: #imageLiteral(resourceName: "slide1")),
            
            OnBoardingSlide(title: "Instant World-Wide Delivery",
                            description: "Your orders will be delivered instantly irrespective of your location around the world.",
                            image: #imageLiteral(resourceName: "slide3"))
        ]
        
        pageControll.numberOfPages = slides.count
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if currentPage == slides.count - 1 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyBoard.instantiateViewController(identifier: "MainTabBarController") as! UITabBarController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .crossDissolve
            UserDefaults.standard.hasOnBoarded = true
            present(controller, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideCollectionViewCell.identifire, for: indexPath) as! SlideCollectionViewCell
        cell.setupView(with: slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
