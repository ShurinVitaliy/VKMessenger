//
//  MessageDialog.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/11/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class MessageDialog {
    private(set) var nameOfDialog: String!
    private var photo: UIImageView!
    private var messagesInDialog: [String]
    private var countOfMessage: Int {
        return messagesInDialog.count
    }
    
    init(nameOfDialog: String, photo: UIImageView, messagesInDialog: [String]) {
        self.nameOfDialog = nameOfDialog
        self.photo = photo
        self.messagesInDialog = messagesInDialog
    }
}
