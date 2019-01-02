//
//  InitializationViewController.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/2/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit

class InitializationViewController: UIViewController {
    
    private var viewModel: InitializationViewModel?
    private var textFieldPhoneNumber: UITextField!
    private var textFieldPassword: UITextField!
    
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
        textFieldPhoneNumber = setupTextField(placeholder: "Phone number")
        self.view.addSubview(textFieldPhoneNumber)
        textFieldPassword = setupTextField(placeholder: "password")
        self.view.addSubview(textFieldPassword)
        setupConstraints()
    }
    
    private func setupTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = .boldSystemFont(ofSize: 25)
        textField.placeholder = placeholder
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private func setupConstraints() {
        
        textFieldPhoneNumber.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textFieldPhoneNumber.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -40).isActive = true
        textFieldPhoneNumber.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        textFieldPhoneNumber.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        textFieldPassword.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textFieldPassword.topAnchor.constraint(equalTo: self.textFieldPhoneNumber.bottomAnchor, constant: 16).isActive = true
        textFieldPassword.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        textFieldPassword.heightAnchor.constraint(equalToConstant: 32).isActive = true
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
