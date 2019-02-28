//
//  MessagesController.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/26/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class MessagesController: UIViewController {
    private var tableView: UITableView!
    private let cellName = MessageTableViewCell.cellName
    private var imageManager = ImageManager.shared
    private var messages: [MessageListItem] = []
    private var userDictionary: [Int: (name: String,image: String)] = [:]
    
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .darkGray
        return refreshControl
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        tableView.addSubview(refreshControl)
    }
    
    override func loadView() {
        loadChatList()
        tableView = setupTableView()
        self.view = tableView
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadChatList()
    }
    
    private func loadChatList() {
        MessagesProvider.loadMessagesListItems({[weak self] (messages) in
            DispatchQueue.main.async {
                self?.messages = messages ?? []
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        })
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.282201767, green: 0.4674475789, blue: 0.6288158894, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
    
    private func setupCellInfo(userId: Int, indexPath: IndexPath) {
        UserProvider.loadUser(userId: userId, {[weak self] (user) in
            DispatchQueue.main.async {
                guard let user = user else {
                    return
                }
                self?.userDictionary[userId] = (user.first_name + " " + user.last_name, user.photo_100)
                (self?.tableView.cellForRow(at: indexPath) as? MessageTableViewCell)?.dialogName.text = user.first_name + " " + user.last_name
                
                self?.imageManager.getImage(imageURL: user.photo_100, complete: {[weak self] (image) in
                    (self?.tableView.cellForRow(at: indexPath) as? MessageTableViewCell)?.dialogImage.image = image
                })
            }
        })
    }
}


extension MessagesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! MessageTableViewCell
        if let message = messages[indexPath.row].message {

            cell.dialogName.text = ""
            cell.dialogImage.image = nil
            cell.dialogBody.text = message.body
            
            if !message.title.isEmpty {
                cell.dialogName.text = message.title
            } else {
                guard let userId = message.user_id else {
                    return cell
                }
                if let userInfo = userDictionary[userId] {
                    cell.dialogName.text = userInfo.name
                    imageManager.getImage(imageURL: userInfo.image, complete: {(image) in
                        cell.dialogImage.image = image
                    })
                } else {
                    setupCellInfo(userId: userId, indexPath: indexPath)
                    print(userDictionary)
                }
            }
        }
        return cell
    }
}

extension MessagesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id =  messages[indexPath.row].message?.user_id {
            self.tableView.cellForRow(at: indexPath)?.isSelected = false
            UserProvider.loadUser(userId: id, {[weak self] (user) in
                guard let user = user  else {
                    return
                }
                DispatchQueue.main.async {
                    let friend = FriendImp.init(first_name: user.first_name, id: user.id, last_name: user.last_name, online: 0, photo_100: user.photo_100)
                    let dialogPageController = DialogPageController(friend: friend)
                    self?.navigationController?.pushViewController(dialogPageController, animated: true)
                }
            })
        }
    }
}
