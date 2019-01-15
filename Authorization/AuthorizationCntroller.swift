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
    private var authorizationProvider: AuthorizationProvider!
    private var buttonLogIn: UIButton!
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.authorizationProvider = AuthorizationProviderImp()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func loadView() {
        authorizationProvider.delegate = self
        let authotizationView = AuthorizationView(frame: CGRect.zero)
        authotizationView.buttonLogIn.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        self.view = authotizationView
    }
    
    @objc private func logIn(_ sender: UIButton) {
        authorizationProvider.logIn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AuthorizationController: AuthorizationProviderDelegate {
    func controllerPresent(_ controller: UIViewController!) {
        present(controller, animated: true, completion: nil)
    }
    
    func complete() {
        let friendsController = FriendsController()
        print("present")
        self.dismiss(animated: true, completion: nil)
        present(friendsController, animated: true, completion: nil)
    }
}
