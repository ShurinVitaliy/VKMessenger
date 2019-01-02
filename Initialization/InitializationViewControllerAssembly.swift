//
//  InitializationViewControllerAssembly.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/2/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation
import UIKit

class InitializationViewControllerAssembly {
    func createController() -> UIViewController {
        let controller = UINavigationController()
        let router = InitializationViewRouter(navigationController: controller)
        let model = InitializationViewModelImp(router: router)
        controller.viewControllers = [InitializationViewController(viewModel: model)]
        return controller
    }
}
