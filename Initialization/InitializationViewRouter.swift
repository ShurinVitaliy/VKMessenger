//
//  InitializationViewRouter.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/2/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import SafariServices
import UIKit
import VK_ios_sdk

class InitializationViewRouter: NSObject {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func createAlerInitialization(_ vk_app_id: String) {
        let sdkInstance = VKSdk.initialize(withAppId: vk_app_id)
        sdkInstance?.register(self)
        sdkInstance?.uiDelegate = self
        VKSdk.wakeUpSession([], complete: { (state: VKAuthorizationState, error: Error?) in
            if state == .authorized {
                
            } else {
                VKSdk.authorize([])
            }
        })
    }
}

extension InitializationViewRouter: VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkUserAuthorizationFailed() {
        
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        navigationController.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
        if let token = result.token {
            if let accesToken = token.accessToken, let userId = token.userId {
                
                print(accesToken)
                print(userId)
                
                UserDefaults.standard.set(accesToken, forKey: "accesToken")
                UserDefaults.standard.synchronize()
                UserDefaults.standard.set(userId, forKey: "userId")
                UserDefaults.standard.synchronize()
            }
        }
    }
    
}

