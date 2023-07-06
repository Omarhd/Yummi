//
//  ChatDetailsModel.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 28/11/2022.
//

import MessageKit

struct Sender: SenderType {
    
    var senderId: String
    var displayName: String
}

struct Messages: MessageType {
    
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}

struct Media: MediaItem {
    
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
}
