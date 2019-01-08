//
//  InitializationViewModel.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/2/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation

protocol InitializationViewModel {
    func initializationWithVKApp(_ initializationSuccess: @escaping() -> Void)
}

class InitializationViewModelImp: InitializationViewModel {
    
    private let router: InitializationViewRouter
    
    func initializationWithVKApp(_ initializationSuccess: @escaping () -> Void) {
        router.createAlerInitialization({
            initializationSuccess()
        })
    }
    
    init(router: InitializationViewRouter) {
        self.router = router
    }
    
}
