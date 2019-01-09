//
//  InitializationViewModel.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/2/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation

protocol InitializationViewModel {
    func initializationWithVKApp()
}

class InitializationViewModelImp: InitializationViewModel {
    
    private let router: InitializationViewRouter
    private let vk_app_id: String = "6804688"
    
    func initializationWithVKApp() {
        router.createAlerInitialization(vk_app_id)
    }
    
    init(router: InitializationViewRouter) {
        self.router = router
    }
    
}
