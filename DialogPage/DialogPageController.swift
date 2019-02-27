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

    //TODO: What is the reason to have those constants?
    private let leftCellName = LeftTableViewCell.cellName
    private let rightCellName = RightTableViewCell.cellName
    
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
        dialogTableView.register(UINib(nibName: leftCellName, bundle: nil), forCellReuseIdentifier: leftCellName)
        dialogTableView.register(UINib(nibName: rightCellName, bundle: nil), forCellReuseIdentifier: rightCellName)
        dialogTableView.separatorColor = .clear
        dialogTableView.allowsSelection = false
        dialogTableView.dataSource = self
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
                if self?.view.frame.origin.y == 0 {
                    self?.view.frame.origin.y -= keyboardSize.height
                }
            }
        })
        observerHideKeyBoard = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main, using:{[weak self] notification in
            //TODO: Use UItableView.contentInset instead of frame
            if self?.view.frame.origin.y != 0 {
                self?.view.frame.origin.y = 0
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
        //TODO: That is not the right place to add spinner. Please check methods of UIScrollViewDelegate. And find more accurate place
        let contentSize = tableView.contentSize.height
        let tableSize = tableView.frame.size.height - tableView.contentInset.top - tableView.contentInset.bottom
        
        let currentOffset = tableView.contentOffset.y
        let maximumOffset = contentSize - tableView.frame.size.height
        let difference = maximumOffset - currentOffset
        
        if contentSize > tableSize, difference <= -40.0 {
            spinner.startAnimating()
            loadChatList()
        }
        
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

//TODO: Should be in a separate file

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
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        layer.add(animation, forKey: "shake")
    }
}
