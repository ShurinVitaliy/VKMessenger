//
//  DialogPageController.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 2/19/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class DialogPageController: UIViewController {
    
    @IBOutlet var dialogSendMessageButton: UIButton!
    @IBOutlet var dialogTextField: UITextField!
    @IBOutlet var dialogTableView: UITableView!
    private var timer = Timer()

    private var friend: Friend
    private var messages: [DialogListItems]?
    
    private var observerShowKeyBoard: NSObjectProtocol!
    private var observerHideKeyBoard: NSObjectProtocol!
    
    private var spinner: UIActivityIndicatorView!
    
    init(friend: Friend) {
        self.friend = friend
        super.init(nibName: nil, bundle: nil)
        spinner = setupSpiner()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = friend.last_name
        self.hideKeyboard()
        setupTable()
        loadChatList()
        setupObserverKeyboard()
        dialogSendMessageButton.layer.cornerRadius = dialogSendMessageButton.bounds.height/2
        //TODO: You init timer on view did load and invalidate it on viewWillDissapear the problem is that if you present some controller from from dialog page and then dismiss it your timer won't work.
        // но я так и пологал, чтобы дизэйблить таймер и у меня у меня удалялся из памяти мой контроллер, если я не буду диэйблить таймер - контроллер не будет удаляться
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(loadChatList), userInfo: nil, repeats: true)
    }
    
    @objc private func loadChatList() {
        DialogPageProvider.loadDialogPageMessage(friendId:String(friend.id), {[weak self] (messages) in
            DispatchQueue.main.async {
                self?.messages = messages
                self?.dialogTableView.reloadData()
                self?.dialogTableView.scrollToBottom()
                self?.spinner.stopAnimating()
            }
        })
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        if !(dialogTextField.text ?? "").isEmpty {
            DialogPageProvider.sendMessage(userId: String(friend.id), message: dialogTextField.text!, {[weak self] (flag) in
                DispatchQueue.main.async {
                    if flag {
                        self?.dialogTextField.text = ""
                        self?.loadChatList()
                    } else {
                        self?.dialogSendMessageButton.shake()
                    }
                }
            })
        } else {
            dialogTextField.shake()
        }
    }
    
    private func setupTable() {
        dialogTableView.register(UINib(nibName: "LeftTableViewCell", bundle: nil), forCellReuseIdentifier: "LeftTableViewCell")
        dialogTableView.register(UINib(nibName: "RightTableViewCell", bundle: nil), forCellReuseIdentifier: "RightTableViewCell")
        dialogTableView.separatorColor = .clear
        dialogTableView.allowsSelection = false
        dialogTableView.dataSource = self
        (dialogTableView as UIScrollView).delegate = self
        dialogTableView.tableFooterView = spinner
    }
    
    private func setupSpiner() -> UIActivityIndicatorView! {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        return spinner
    }
    
    private func setupObserverKeyboard() {
        observerShowKeyBoard = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main, using: {[weak self] notification in
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                //TODO: Use UItableView.contentInset instead of frame
                //print(self?.dialogTableView.contentInset)
                
                if self?.dialogTableView.contentInset.top == 0 {
                    self?.dialogTableView.contentInset.top -= keyboardSize.height
                }
                /*
                if self?.view.frame.origin.y == 0 {
                    self?.view.frame.origin.y -= keyboardSize.height
                }*/
            }
        })
        observerHideKeyBoard = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main, using:{[weak self] notification in
            //TODO: Use UItableView.contentInset instead of frame
            //но мне же нужно поднимать и опускать вьюху а не таблицу
            //print(self?.dialogTableView.contentInset)
           /* if self?.view.frame.origin.y != 0 {
                self?.view.frame.origin.y = 0
            }*/
            if self?.dialogTableView.contentInset.top != 0 {
                self?.dialogTableView.contentInset.top = 0
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(observerShowKeyBoard)
        NotificationCenter.default.removeObserver(observerHideKeyBoard)
    }
}

extension DialogPageController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let message = messages?[indexPath.row]
        if message?.out == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightTableViewCell", for: indexPath) as? DialogTableViewCell
            cell?.messageLabel.text = message?.body
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftTableViewCell", for: indexPath) as? DialogTableViewCell
            cell?.messageLabel.text = message?.body
            return cell!
        }
    }
}

extension DialogPageController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let contentSize = scrollView.contentSize.height
        let tableSize = scrollView.frame.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom
        
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = contentSize - scrollView.frame.size.height
        let difference = maximumOffset - currentOffset
        
        if contentSize > tableSize, difference <= -80.0 {
            spinner.startAnimating()
            loadChatList()
        }
    }
}
