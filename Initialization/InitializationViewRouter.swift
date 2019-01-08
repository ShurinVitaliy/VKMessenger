//
//  InitializationViewRouter.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/2/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class InitializationViewRouter {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func createAlerInitialization(_ initializationSuccessWithVk: @escaping () -> Void) {
        let alert = UIAlertController(title: "Log in with the current application?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            initializationSuccessWithVk()
        }))
        alert.addAction(UIAlertAction(title: "No thanks!", style: .cancel))
        navigationController.present(alert, animated: true, completion: nil)
    }
}
