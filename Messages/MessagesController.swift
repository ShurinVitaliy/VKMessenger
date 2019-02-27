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
    private var searchBar: UISearchBar!
    private let cellName = MessageTableViewCell.cellName
    private var imageManager = ImageManager.shared
    private var messages: [MessageListItem] = []
    
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
        searchBar = createSearchBar()
        setupNavigationController()
        tableView.addSubview(refreshControl)
    }
    
    override func loadView() {
        loadChatList()
        tableView = setupTableView()
        self.view = tableView
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
    }
    
    private func loadChatList() {
        let messagesManager = MessagesManager()
        messagesManager.getFullMessagesList({[weak self] (fullStructMessages) in
            DispatchQueue.main.async {
                print(fullStructMessages)
                self?.messages = fullStructMessages ?? []
                self?.tableView.reloadData()
            }
        })
    }
    
    private func setupNavigationController() {
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.282201767, green: 0.4674475789, blue: 0.6288158894, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func createSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.placeholder = "messages search"
        //searchBar.delegate = self
        return searchBar
    }
    
    private func setupTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.dataSource = self
        return tableView
    }
    
    private func setupCellInfo(message: Message, indexPath: IndexPath) {
        if let userId = message.user_id {
            /*UserProvider.loadUser(userId: userId, {[weak self] (user) in
                DispatchQueue.main.async {
                    (self?.tableView.cellForRow(at: indexPath) as? MessageTableViewCell)?.dialogName.text = (user?.first_name ?? "" ) + " " + (user?.last_name ?? "")
                    self?.messages[indexPath.row].message?.userName = (user?.first_name ?? "" ) + " " + (user?.last_name ?? "")
                }
            })*/
        }
    }
}


extension MessagesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! MessageTableViewCell
        if let message = messages[indexPath.row].message {
            cell.imageView?.image = nil
            cell.dialogName.text = message.title
            cell.dialogBody.text = message.body
            /*
            //cell.dialogName.text = ""
            cell.dialogBody.text = message.body
            if !(message.title).isEmpty {
                cell.dialogName.text = message.title
            } else if message.userName != nil {
                cell.dialogName.text = message.userName
            } else {
                self.setupCellInfo(message: message, indexPath: indexPath)
            }*/
        }
        return cell
    }
}
