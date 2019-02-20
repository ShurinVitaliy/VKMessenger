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
    //private var timer = Timer()
    
    private let leftCellName = LeftTableViewCell.cellName
    private let rightCellName = RightTableViewCell.cellName
    
    private var friend: Friend
    private var messages: [DialogListItems]?
    
    init(friend: Friend) {
        self.friend = friend
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = friend.first_name! + " " + friend.last_name!
        setupTable()
        dialogSendMessageButton.layer.cornerRadius = dialogSendMessageButton.bounds.height/2
        loadChatList()
        //timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(loadChatList), userInfo: nil, repeats: true)
        self.hideKeyboard() //непонятное поведение кода открываю второй раз клаиватуру то её размер уже не 253 а 216

        /*
        let sas = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main, using: {[weak self] notification in
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self?.view.frame.origin.y == 0 {
                    self?.view.frame.origin.y -= keyboardSize.height
                    print(self?.view.frame.origin.y)
                    print(keyboardSize.height)
                }
            }
        })
        //NotificationCenter.default.removeObserver(sas)
        
        let sis = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main, using:{[weak self] notification in
            if self?.view.frame.origin.y != 0 {
                self?.view.frame.origin.y = 0
            }
        })*/
        //NotificationCenter.default.removeObserver(sis)
        
        let observerShowKeyBord = NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        let observerHideKeyBord = NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //NotificationCenter.default.removeObserver(observerHideKeyBord)
        //NotificationCenter.default.removeObserver(observerShowKeyBord)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                print(self.view.frame.origin.y)
                print(keyboardSize.height)
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc private func loadChatList() {
        DialogPageProvider.loadFriendPageImage(friendId:String(friend.id), {[weak self] (messages) in
            DispatchQueue.main.async {
                self?.messages = messages
                self?.dialogTableView.reloadData()
                self?.dialogTableView.scrollToBottom()
            }
        })
    }
    
    private func setupTable() {
        dialogTableView.register(UINib(nibName: leftCellName, bundle: nil), forCellReuseIdentifier: leftCellName)
        dialogTableView.register(UINib(nibName: rightCellName, bundle: nil), forCellReuseIdentifier: rightCellName)
        dialogTableView.separatorColor = .clear
        dialogTableView.allowsSelection = false
        dialogTableView.dataSource = self
    }
    @IBAction func sendMessage(_ sender: Any) {
        if !(dialogTextField.text ?? "").isEmpty {
            DialogManager.sendMessage(userId: String(friend.id), message: dialogTextField.text!, {[weak self] (flag) in
                DispatchQueue.main.async {
                    if flag {
                        self?.loadChatList()
                        self?.dialogTextField.text = ""
                    }
                }
            })
        }
    }
    
    deinit {
        print(1)
    }
}

extension DialogPageController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages?[indexPath.row]
        if message?.out == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: rightCellName, for: indexPath) as? RightTableViewCell
            cell?.messageLabel.text = message?.body
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: leftCellName, for: indexPath) as? LeftTableViewCell
            cell?.messageLabel.text = message?.body
            return cell!
        }
    }
}

extension UITableView {
    func scrollToBottom() {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        if (rows > 0){
            self.scrollToRow(at: NSIndexPath(row: rows - 1, section: sections - 1) as IndexPath, at: .bottom, animated: false)
        }
    }
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
