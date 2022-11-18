//
//  HomeExtensions.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 17/11/2022.
//

import UIKit
import Instructions

extension HomeViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    
    func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: Instructions.CoachMark) -> (bodyView: (UIView & Instructions.CoachMarkBodyView), arrowView: (UIView & Instructions.CoachMarkArrowView)?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        
        switch index {
        case 0:
            coachViews.bodyView.hintLabel.text = "Hello! this is Our Dishes Category where u can find all our meals!"
            coachViews.bodyView.nextLabel.text = "OK!!"
        case 1:
            coachViews.bodyView.hintLabel.text = "This is Our Popular Dishes, best we made for our clients."
            coachViews.bodyView.nextLabel.text = "Ok!"
        case 2:
            coachViews.bodyView.hintLabel.text = "This is Our Chef's Recommendations"
            coachViews.bodyView.nextLabel.text = "OK!"
        default: break
        }
        
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, coachMarkAt index: Int) -> Instructions.CoachMark {
        switch index {
        case 0: return coachMarksController.helper.makeCoachMark(for: categoryCollectionView)
        case 1: return coachMarksController.helper.makeCoachMark(for: popularCollectionView)
        case 2: return coachMarksController.helper.makeCoachMark(for: chefCollectionView)
        default: return coachMarksController.helper.makeCoachMark()
        }
    }
    
    func numberOfCoachMarks(for coachMarksController: Instructions.CoachMarksController) -> Int {
        return 3
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, didEndShowingBySkipping skipped: Bool) {
        AppManager.setUserSeenAppInstruction()
    }
}

