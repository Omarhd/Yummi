//
//  ChatDetailsViewController.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 28/11/2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import SwiftMessages
import IQKeyboardManagerSwift

class ChatDetailsViewController: MessagesViewController {
    
    let currentUser = Sender(senderId: "self", displayName: "Me")
    let otherUser = Sender(senderId: "tech", displayName: "Tech Support")
    
    var messages = [MessageType]()
    let documentInteractionController = UIDocumentInteractionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProtocols()
        documentInteractionController.delegate = self
        
        scrollsToLastItemOnKeyboardBeginsEditing = false // default false
        maintainPositionOnKeyboardFrameChanged = true // default false
        IQKeyboardManager.shared.enable = false

        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout{
            layout.setMessageIncomingAvatarSize(.zero)
            //            layout.setMessageOutgoingAvatarSize(.zero)
            layout.setMessageOutgoingMessageBottomLabelAlignment(.init(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)))
            layout.setMessageIncomingMessageBottomLabelAlignment(.init(textAlignment: .left, textInsets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)))
            layout.setMessageOutgoingCellBottomLabelAlignment(.init(textAlignment: .right, textInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)))
            
        }
        
        configureMessageInputBar()
        
        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-86500), kind: .text("Hello")))
        messages.append(Message(sender: currentUser, messageId: "2", sentDate: Date().addingTimeInterval(-76500), kind: .text("HI, am omar from ur channel ")))
        messages.append(Message(sender: otherUser, messageId: "3", sentDate: Date().addingTimeInterval(-66500), kind: .text("Hello, we are glade to talk to u")))
        messages.append(Message(sender: otherUser, messageId: "4", sentDate: Date().addingTimeInterval(-56500), kind: .text("Hello")))
        messages.append(Message(sender: currentUser, messageId: "5", sentDate: Date().addingTimeInterval(-46500), kind: .text("Hello")))
        messages.append(Message(sender: otherUser, messageId: "6", sentDate: Date().addingTimeInterval(-36500), kind: .text("Hello")))
        messages.append(Message(sender: currentUser, messageId: "7", sentDate: Date().addingTimeInterval(-26500), kind: .text("Hello")))
        messages.append(Message(sender: otherUser, messageId: "8", sentDate: Date().addingTimeInterval(-16500), kind: .text("Hello")))
        messages.append(Message(sender: currentUser, messageId: "9", sentDate: Date().addingTimeInterval(-19500), kind: .text("Hello")))
        messages.append(Message(sender: otherUser, messageId: "10", sentDate: Date().addingTimeInterval(-12500), kind: .photo(Media(placeholderImage: UIImage(systemName: "square.and.arrow.up.on.square.fill")!, size: CGSize(width: 250, height: 100)))))
        messages.append(Message(sender: currentUser, messageId: "11", sentDate: Date().addingTimeInterval(-16590), kind: .text("Hello")))
        
    }
    
    fileprivate func setupProtocols() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messageCellDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
    
    fileprivate func configureMessageInputBar() {
        
        messageInputBar.delegate = self
        messageInputBar.inputTextView.isUserInteractionEnabled = true
        messageInputBar.inputTextView.resignFirstResponder()

        let button = InputBarButtonItem()
        button.image = UIImage(systemName: "plus.bubble")
        button.setSize(CGSize(width: 40, height: 40), animated: true)
        button.cornerRadius = 8
        
        button.onKeyboardSwipeGesture { item, gesture in
            if (gesture.direction == .left)     { item.inputBarAccessoryView?.setLeftStackViewWidthConstant(to: 20, animated: true)        }
            if (gesture.direction == .right) { item.inputBarAccessoryView?.setLeftStackViewWidthConstant(to: 20, animated: true)    }
        }
        
        button.onTouchUpInside { item in
            self.actionAttachMessage()
        }
        
        messageInputBar.setStackViewItems([button], forStack: .left, animated: false)
        
        messageInputBar.sendButton.title = nil
        messageInputBar.sendButton.image = UIImage(systemName: "paperplane.fill")
        messageInputBar.sendButton.setSize(CGSize(width: 40, height: 40), animated: true)
        
        messageInputBar.setLeftStackViewWidthConstant(to: 40, animated: true)
        messageInputBar.setRightStackViewWidthConstant(to: 20, animated: true)
        
        messageInputBar.inputTextView.isImagePasteEnabled = true
        messageInputBar.inputTextView.placeholder = nil
        
        messageInputBar.inputTextView.delegate = self
        
        messageInputBar.backgroundView.backgroundColor = .clear
        messageInputBar.backgroundView.borderWidth = 1.0
        messageInputBar.backgroundView.borderColor = .clear
        messageInputBar.inputTextView.backgroundColor = UIColor(named: "Cells")
        
        messageInputBar.leftStackView.backgroundColor = .clear
        messageInputBar.middleContentView?.cornerRadius = 8

    }
    
    func actionAttachMessage() {
        
        messageInputBar.inputTextView.resignFirstResponder()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let alertCamera = UIAlertAction(title: "الكاميرا", style: .default, handler: { action in
            
        })
        let alertPhoto = UIAlertAction(title: "معرض الصور", style: .default, handler: { action in
            
        })
        let alertVideo = UIAlertAction(title: "الفيديو", style: .default, handler: { action in
            
        })
        let alertAudio = UIAlertAction(title: "مقطع صوتي", style: .default, handler: { action in
            
        })
        let alertFile =  UIAlertAction(title: "الملف", style: .default, handler: { (action) in
            self.actionFiles()
            
        })
        let alertLocation = UIAlertAction(title: "الموقع", style: .default, handler: { action in
            
        })
        
        alert.addAction(alertCamera)
        alert.addAction(alertPhoto)
        alert.addAction(alertVideo)
        alert.addAction(alertAudio)
        alert.addAction(alertFile)
        alert.addAction(alertLocation)
        alert.addAction(UIAlertAction(title: "الغاء", style: .cancel, handler: nil))
        
        present(alert, animated: true)
    }
    
    func actionFiles() {
        
        //MARK: - FILE PICKER
        //        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        //        documentPicker.delegate = self
        //        documentPicker.modalPresentationStyle = .formSheet
        //        self.present(documentPicker, animated: true, completion: nil)
        
    }
    
}

extension ChatDetailsViewController: UIDocumentInteractionControllerDelegate {
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}

extension ChatDetailsViewController: MessagesDataSource, MessagesDisplayDelegate, MessagesLayoutDelegate, MessageCellDelegate, InputBarAccessoryViewDelegate {
    
    func currentSender() -> MessageKit.SenderType {
        return self.currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return self.messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return self.messages.count
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let image = UIImage(systemName: "headphones.circle.fill")
        let avatar = Avatar(image: image, initials: "")
        avatarView.set(avatar: avatar)
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if isNextMessageSameSender(at: indexPath) && isFromCurrentSender(message: message) {
                return NSAttributedString(string: "Delivered", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
            }
            return nil
    }
    
    func isTimeLabelVisible(at indexPath: IndexPath) -> Bool {
        return true
    }
    
    func isPreviousMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section - 1 >= 0 else { return false }
        return messages[indexPath.section].sentDate == messages[indexPath.section - 1].sentDate
    }
    
    func isNextMessageSameSender(at indexPath: IndexPath) -> Bool {
        guard indexPath.section + 1 < messages.count else { return false }
        return messages[indexPath.section].sentDate == messages[indexPath.section + 1].sentDate
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
        print(text)
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        
        for component in inputBar.inputTextView.components {
            if let text = component as? String {
                print(text)
                messages.append(Message(sender: otherUser, messageId: "3", sentDate: Date().addingTimeInterval(-0), kind: .text(text)))
                
                self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: false)
                self.messagesCollectionView.reloadData()

            }
        }
    }
    
    func didTapBackground(in cell: MessageKit.MessageCollectionViewCell) {
        print("didTapBackground")
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

extension ChatDetailsViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
}
