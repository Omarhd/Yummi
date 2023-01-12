//
//  DishDetailsExtensions.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 26/11/2022.
//

import UIKit
import Instructions

extension DishesDetailsViewController: CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    
    func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: Instructions.CoachMark) -> (bodyView: (UIView & Instructions.CoachMarkBodyView), arrowView: (UIView & Instructions.CoachMarkArrowView)?) {
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        
        switch index {
        case 0:
            coachViews.bodyView.hintLabel.text = "you can controll your order count for item."
            coachViews.bodyView.nextLabel.text = "OK!!"
        case 1:
            coachViews.bodyView.hintLabel.text = "navigate to check ur cart whenever u wanted."
            coachViews.bodyView.nextLabel.text = "Ok!"
        case 2:
            coachViews.bodyView.hintLabel.text = "and finlly add the item to your cart."
            coachViews.bodyView.nextLabel.text = "OK!"
        default: break
        }
        
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
    
    func coachMarksController(_ coachMarksController: Instructions.CoachMarksController, coachMarkAt index: Int) -> Instructions.CoachMark {
        switch index {
        case 0: return coachMarksController.helper.makeCoachMark(for: stepper)
        case 1: return coachMarksController.helper.makeCoachMark(for: self.navigationItem.rightBarButtonItem?.customView)
        case 2: return coachMarksController.helper.makeCoachMark(for: addButton)
        default: return coachMarksController.helper.makeCoachMark()
        }
    }
    
    func numberOfCoachMarks(for coachMarksController: Instructions.CoachMarksController) -> Int {
        return 3
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, didEndShowingBySkipping skipped: Bool) {
        AppManager.setUserSeenAppInstructionForDishDetails()
    }
}

