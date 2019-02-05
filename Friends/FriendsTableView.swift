//
//  FriendsTableView.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/5/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class FriendsTableView: UITableView {
    let cellName = String(describing: FriendTableViewCell.self)
    var dataSourceTableView: UITableViewDataSource?
    var delegateTableView: UITableViewDelegate?
    
    convenience init() {
        self.init(frame: CGRect.zero, style: .plain)
        register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
