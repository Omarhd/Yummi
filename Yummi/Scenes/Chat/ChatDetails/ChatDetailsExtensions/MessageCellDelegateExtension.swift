//
//  MessageCellDelegateExtension.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 28/11/2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import SwiftMessages
import IQKeyboardManagerSwift

extension ChatDetailsViewController: MessageCellDelegate {
    
    func didTapBackground(in cell: MessageKit.MessageCollectionViewCell) {
        print("didTapBackground")
        self.view.endEditing(true)
    }
    
    func didTapMessage(in cell: MessageKit.MessageCollectionViewCell) {
        print("didTapMessage")
        
    }
    
    func didTapAvatar(in cell: MessageKit.MessageCollectionViewCell) {
        print("didTapAvatar")
    }
    
    func didTapCellTopLabel(in cell: MessageKit.MessageCollectionViewCell) {
        print("didTapCellTopLabel")
        
    }
    
    func didTapCellBottomLabel(in cell: MessageKit.MessageCollectionViewCell) {
        print("didTapCellBottomLabel")
        
    }
    
    func didTapMessageTopLabel(in cell: MessageKit.MessageCollectionViewCell) {
        print("didTapMessageTopLabel")
        
    }
    
    func didTapMessageBottomLabel(in cell: MessageKit.MessageCollectionViewCell) {
        print("didTapMessageBottomLabel")
        
    }
    
    func didTapAccessoryView(in cell: MessageKit.MessageCollectionViewCell) {
        print("didTapAccessoryView")
        
    }
    
    func didTapImage(in cell: MessageKit.MessageCollectionViewCell) {
        print("didTapImage")
        
    }
    
    func didTapPlayButton(in cell: MessageKit.AudioMessageCell) {
        print("didTapPlayButton")
        
    }
    
    func didStartAudio(in cell: MessageKit.AudioMessageCell) {
        print("didStartAudio")
        
    }
    
    func didPauseAudio(in cell: MessageKit.AudioMessageCell) {
        print("didPauseAudio")
        
    }
    
    func didStopAudio(in cell: MessageKit.AudioMessageCell) {
        print("didStopAudio")
        
    }
}
