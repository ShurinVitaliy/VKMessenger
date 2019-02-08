//
//  FriendPageController.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/7/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class FriendPageController: UIViewController {

    private var friend: Friend!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var friendPageHeader: FriendPageHeader! = FriendPageHeader()
    
    init(friend: Friend) {
        super.init(nibName: String(describing: FriendPageController.self), bundle: nil)
        self.friend = friend
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = friend.first_name
        scrollView.backgroundColor = UIColor.lightGray
        (stackView.arrangedSubviews.first as? FriendPageHeader)?.setupData(friend: friend)
        
    }
}

