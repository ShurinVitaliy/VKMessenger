//
//  AuthorizationProvider.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/14/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit
import VK_ios_sdk

protocol AuthorizationProvider {
    func logIn()
    var delegate: AuthorizationProviderDelegate? {get set}
}

protocol AuthorizationProviderDelegate: class{
    func willPresentController(_ controller: UIViewController!)
    func didAcces()
}

class AuthorizationProviderImp: NSObject, AuthorizationProvider {
    private let vk_app_id: String = "6804688"
    weak var delegate: AuthorizationProviderDelegate?
    
    func logIn() -> Void {
        let sdkInstance = VKSdk.initialize(withAppId: vk_app_id)
        sdkInstance?.register(self)
        sdkInstance?.uiDelegate = self
        VKSdk.wakeUpSession(["friends", "email"], complete: { (state: VKAuthorizationState, error: Error?) in
            if state != .authorized {
                VKSdk.authorize([])
            } else {
                self.delegate?.didAcces()
            }
        })
    }
}

extension AuthorizationProviderImp: VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.willPresentController(controller)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        delegate?.didAcces()
    }
}
