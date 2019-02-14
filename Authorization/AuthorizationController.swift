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
    private var coreAnimation: CABasicAnimation!
    private var authorizationView: AuthorizationView? {
        return (view as? AuthorizationView)
    }
    
    init(authorizationProvider: AuthorizationProvider) {
        super.init(nibName: nil, bundle: nil)
        self.authorizationProvider = authorizationProvider
        coreAnimation = createAnimationbutton()
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
    
    private func createAnimationbutton() -> CABasicAnimation {
        let coreAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.cornerRadius))
        coreAnimation.fromValue = 18
        coreAnimation.toValue = 1
        coreAnimation.duration = 0.1
        return coreAnimation
    }
    
    @objc private func logIn(_ sender: UIButton) {
        
        //authorizationView?.buttonLogIn.layer.cornerRadius = 1
        //authorizationView?.buttonLogIn.layer.add(coreAnimation, forKey: #keyPath(CALayer.cornerRadius))
        
        UIView.animate(withDuration: 0.2, animations: {[weak self] in
            self?.authorizationView?.buttonLogIn.transform = CGAffineTransform(translationX: -200, y: 0)
        })
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: UIView.AnimationOptions.allowAnimatedContent, animations: {
            self.authorizationView?.buttonLogIn.transform = CGAffineTransform(translationX: 0, y: -100)
            self.authorizationView?.backgroundColor = #colorLiteral(red: 0.282201767, green: 0.4674475789, blue: 0.6288158894, alpha: 1)
            self.authorizationView?.buttonLogIn.backgroundColor = #colorLiteral(red: 0.282201767, green: 0.4674475789, blue: 0.6288158894, alpha: 1)
            self.authorizationView?.buttonLogIn.titleLabel?.alpha = 0
        }, completion: nil)

        
        authorizationProvider.logIn()
        authorizationView?.buttonLogIn.isEnabled = false
    }
}

extension AuthorizationController: AuthorizationProviderDelegate {
    func presentController(_ controller: UIViewController!) {
        present(controller, animated: true, completion: nil)
    }
    
    func authorizationСompleted() {
        let controller = UINavigationController()
        let friendController = FriendsController()
        controller.viewControllers = [friendController]
        present(controller, animated: true, completion: nil)
    }
}

