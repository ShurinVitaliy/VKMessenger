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
    func controllerPresent(_ controller: UIViewController!)
    func complete()
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
        delegate?.controllerPresent(controller)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if let token = result.token {
            if let accesToken = token.accessToken, let userId = token.userId {
                UserDefaults.standard.set(accesToken, forKey: "accesToken")
                UserDefaults.standard.synchronize()
                UserDefaults.standard.set(userId, forKey: "userId")
                UserDefaults.standard.synchronize()
                delegate?.complete()
            }
        }
    }
    
}
//VKSdk.accessToken()?.userId
