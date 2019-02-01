//
//  FriendPageController.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/1/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class FriendPageController: UIViewController {
    
    var friendPageHeaderView: FriendPageHeaderView!
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendPageHeaderView = FriendPageHeaderView(width: 375, height: 960)
        self.view.addSubview(friendPageHeaderView)
        
        
    }
}
