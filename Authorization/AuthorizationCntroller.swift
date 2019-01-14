//
//  AuthorizationCntroller.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/14/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationController: UIViewController {
    var authorizationProvider: AuthorizationProvider!
    private var buttonLogIn: UIButton!
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.authorizationProvider = AuthorizationProviderImp(controllerAuth: self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        buttonLogIn = setupButton(title: "Log In")
        view.addSubview(buttonLogIn)
        setupConstraints()
    }
    
    func setupButton(title: String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.darkGray
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }
    
    private func setupConstraints() {
        buttonLogIn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonLogIn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        buttonLogIn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        buttonLogIn.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    @objc private func logIn(_ sender: UIButton) {
        authorizationProvider.logIn()
    }
    
    func complete() {
        let friendsController = FriendsController()
        print("present")
        self.dismiss(animated: true, completion: nil)
        present(friendsController, animated: true, completion: nil)
        /*
        if let token = UserDefaults.standard.object(forKey: "accesToken") as? String, let userId = UserDefaults.standard.object(forKey: "userId") as? String {
            print(token
            print(userId)
        } else {
            print("acces Token - nil, userId - nil")
        }*/
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
