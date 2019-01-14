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
}

class AuthorizationProviderImp: NSObject, AuthorizationProvider {
    let vk_app_id: String = "6804688"
    var controllerAuth: AuthorizationController!
    init(controllerAuth: AuthorizationController) {
        self.controllerAuth = controllerAuth
    }
    
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
        controllerAuth.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if let token = result.token {
            if let accesToken = token.accessToken, let userId = token.userId {
                UserDefaults.standard.set(accesToken, forKey: "accesToken")
                UserDefaults.standard.synchronize()
                UserDefaults.standard.set(userId, forKey: "userId")
                UserDefaults.standard.synchronize()
                controllerAuth.complete()
            }
        }
    }
    
}
