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
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        friendsModel = FriendsModelImp(friendsController: self)
        friendsModel.delegate = self
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
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
        let cell = Bundle.main.loadNibNamed("FriendTableViewCell", owner: self, options: nil)?.first as! FriendTableViewCell
        let friend = friendsModel.getFriends()[indexPath.row]
        cell.firstNameLabel.text = friend.first_name
        cell.lastNameLabel.text = friend.last_name
        // не оптимально! нужно сделать загрузку изображений асинхронно
        //cell.photoImageView.image = friend.photoImageView
        return cell
    }
}
extension FriendsController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension FriendsController: FriendsModelDelegate {
    func gettingFriendsDidComplete() {
        DispatchQueue.main.async {
            if (self.tableView != nil) {
                self.tableView.reloadData()
            }
        } // правилльно ли я сделал? знаю что так будет работать, если без проверки то работает через раз, потому что бывает что получаем друзей раньше чем создётся таблица
    }
}

