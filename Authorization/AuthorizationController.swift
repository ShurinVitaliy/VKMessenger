//
//  AuthorizationCntroller.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/14/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit
import VK_ios_sdk

class AuthorizationController: UIViewController {
    private var authorizationProvider: AuthorizationProvider!
    
    convenience init(authorizationProvider: AuthorizationProvider) {
        self.init(nibName: nil, bundle: nil)
        self.authorizationProvider = authorizationProvider
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        authorizationProvider.delegate = self
        let authotizationView = AuthorizationView()
        authotizationView.buttonLogIn.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        self.view = authotizationView
    }
    
    @objc private func logIn(_ sender: UIButton) {
        authorizationProvider.logIn()
        (self.view as? AuthorizationView)?.buttonLogIn.isEnabled = false
    }
}

extension AuthorizationController: AuthorizationProviderDelegate {
    func presentController(_ controller: UIViewController!) {
        present(controller, animated: true, completion: nil)
    }
    
    func authorizationСompleted() {
        /*
        let friendsController = FriendsController()
        self.dismiss(animated: true, completion: nil)
        present(friendsController, animated: true, completion: nil)
        */
        let controller = UINavigationController()
        let friendController = FriendsController(controller: controller)
        controller.viewControllers = [friendController]
        self.dismiss(animated: true, completion: nil)
        present(controller, animated: true, completion: nil)

    }
}

