//
//  ChatDetailsInputBarExtensions.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 28/11/2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import SwiftMessages
import IQKeyboardManagerSwift

extension ChatDetailsViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        for component in inputBar.inputTextView.components {
            if let text = component as? String {
                print(text)
                messages.append(Message(sender: otherUser, messageId: "3", sentDate: Date().addingTimeInterval(+20454), kind: .text(text)))
                DispatchQueue.main.async {
                    self.messagesCollectionView.scrollToItem(at: IndexPath(row: 0, section: self.messages.count - 1), at: .top, animated: false)
                   }
                inputBar.inputTextView.text = ""
                self.messagesCollectionView.reloadData()

            }
        }
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
        print(text)
    }

    
    func configureMessageInputBar() {
        
        messageInputBar.delegate = self
        messageInputBar.inputTextView.isUserInteractionEnabled = true
        messageInputBar.inputTextView.resignFirstResponder()
        messageInputBar.sendButton.contentMode = .scaleAspectFill

        messageInputBar.sendButton.title = nil
        messageInputBar.sendButton.image = UIImage(systemName: "paperplane.fill")
        messageInputBar.sendButton.contentMode = .scaleAspectFill
        messageInputBar.sendButton.tintColor = .link
        messageInputBar.sendButton.setSize(CGSize(width: 36, height: 40), animated: true)
        
        let button = InputBarButtonItem()
        button.image = UIImage(systemName: "plus")
        button.tintColor = .link
        button.setSize(CGSize(width: 36, height: 40), animated: true)
        
        button.onKeyboardSwipeGesture { item, gesture in
            if (gesture.direction == .left)     { item.inputBarAccessoryView?.setLeftStackViewWidthConstant(to: 20, animated: true)        }
            if (gesture.direction == .right) { item.inputBarAccessoryView?.setLeftStackViewWidthConstant(to: 20, animated: true)    }
        }
        
        button.onTouchUpInside { item in
            self.actionAttachMessage()
        }
        
        messageInputBar.setStackViewItems([button], forStack: .left, animated: true)
        
        messageInputBar.setLeftStackViewWidthConstant(to: 40, animated: true)
        messageInputBar.setRightStackViewWidthConstant(to: 20, animated: true)
        
        messageInputBar.inputTextView.isImagePasteEnabled = true
        messageInputBar.inputTextView.placeholder = nil
                
        messageInputBar.backgroundView.backgroundColor = .clear
        messageInputBar.backgroundView.borderWidth = 1.0
        messageInputBar.backgroundView.borderColor = .clear
        messageInputBar.inputTextView.backgroundColor = UIColor(named: "Cells")
        
        messageInputBar.leftStackView.backgroundColor = .clear
        messageInputBar.middleContentView?.cornerRadius = 8

    }
}
