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
    
    
    
    func actionAttachMessage() {
        
        messageInputBar.inputTextView.resignFirstResponder()
        
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let alertCamera = UIAlertAction(title: "Image", style: .default, handler: { action in
            self.showAlert()
        })
        
        let image = UIImage(systemName: "camera.fill")
        alertCamera.setValue(image, forKey: "image")
        
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

extension ChatDetailsViewController: MessagesDataSource, MessagesLayoutDelegate {
    
    func currentSender() -> MessageKit.SenderType {
        return self.currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return self.messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return self.messages.count
    }
        
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        if !isNextMessageSameSender(at: indexPath) && !isFromCurrentSender(message: message) {
            return NSAttributedString(string: "read", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .footnote)])
            }
        return NSAttributedString(string: "deliverd", attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption1)])
    }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
        
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 30.0
    }
        
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }

    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 10.0
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
        
}

extension ChatDetailsViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
}
