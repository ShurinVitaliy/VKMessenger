//
//  InitializationViewModel.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/2/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import Foundation

protocol InitializationViewModel {
    
}

class InitializationViewModelImp: InitializationViewModel {
    private let router: InitializationViewRouter
    
    init(router: InitializationViewRouter) {
        self.router = router
    }
}
