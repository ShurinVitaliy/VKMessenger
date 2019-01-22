//
//  FriendsController.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/14/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class FriendsController: UIViewController {
    var friendsModel: FriendsModel!
    private var tableView: UITableView!
    
    convenience init(friendsModel: FriendsModel) {
        self.init(nibName: nil, bundle: nil)
        self.friendsModel = friendsModel// FriendsModelImp()
        self.friendsModel.delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = createTableView()
        view.addSubview(tableView)
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendTableViewCell")
        return tableView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FriendsController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsModel.countOfFriends()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friendsModel.getFriends()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell", for: indexPath) as! FriendTableViewCell
        cell.firstNameLabel.text = friend.first_name
        cell.lastNameLabel.text = friend.last_name
        friendsModel.getImage(indexPath: indexPath, friend: friend)
        return cell
    }
}
extension FriendsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension FriendsController: FriendsModelDelegate {
    func gettingImageDidComplete(indexPath: IndexPath, image: UIImage) {
        DispatchQueue.main.async {
            (self.tableView.cellForRow(at: indexPath) as? FriendTableViewCell)?.photoImageView.image = image
        }
    }
    
    func gettingFriendsDidComplete() {
        DispatchQueue.main.async {
            if (self.tableView != nil) {
                self.tableView.reloadData()
            }
        }
    }
}




