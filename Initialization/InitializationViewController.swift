//
//  InitializationViewController.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/2/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

import VK_ios_sdk

class InitializationViewController: UIViewController {
    
    private var viewModel: InitializationViewModel?
    
    convenience init(viewModel: InitializationViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightText
        
        setupNavigationBar()
        viewModel?.initializationWithVKApp()
        print("token")
        print(UserDefaults.standard.object(forKey: "accesToken") as? String)
        print(UserDefaults.standard.object(forKey: "userId") as? String)
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(signIn))
    }
    
    @objc private func signIn(_ sender: UIBarButtonItem) {
        print("signIn")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
