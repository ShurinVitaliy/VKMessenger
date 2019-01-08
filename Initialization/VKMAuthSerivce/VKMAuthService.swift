//
//  VKMAuthService.swift
//  VKMessenger
//
//  Created by Vitaly Shurin on 1/8/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

import UIKit
import VK_ios_sdk


class VKMAuthService: NSObject {
    static let sharedInstance = VKMAuthService()
    private let sdkInstance = VKSdk.initialize(withAppId: "6804688")
    
    weak var baseController: UIViewController?
    var success: (() -> Void)?
    var failure: (() -> Void)?
    
    func auth(baseController: UIViewController, success: @escaping() -> Void, failure: @escaping() -> Void) {
        if getAccessToken() != "" {
            success()
            return
        }
        
        self.baseController = baseController
        self.success = success
        self.failure = failure
        
        let scope = ["friends","messages","offline"]
        
        sdkInstance?.register(self)
        sdkInstance?.uiDelegate = self
        
        VKSdk.authorize(scope)
    }
}

extension VKMAuthService: VKSdkDelegate, VKSdkUIDelegate {
    func vkSdkUserAuthorizationFailed() {
        print("erroe authorization")
        failure?()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        baseController?.present(controller, animated: true, completion: nil)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        let token = result.token
        
        if token != nil {
            let tokenStr = token!.accessToken
            
            if tokenStr != nil {
                setAccessToken(token: tokenStr!)
                setMyID(identif: result.token!.userId)
                success?()
                return
            }
        }
        
        failure?()
    }
    
}

extension VKMAuthService {
    
    private func setAccessToken ( token: String) {
        UserDefaults.standard.set(token, forKey: "")
        UserDefaults.standard.synchronize()
    }
    
    func getAccessToken () -> String {
        if let tokenStr = UserDefaults.standard.object(forKey: "") as? String {
            return tokenStr
        }
        return ""
    }
    
    private func setMyID ( identif: String) {
        UserDefaults.standard.set(identif, forKey: "")
        UserDefaults.standard.synchronize()
    }
    
    func getMyID () -> String {
        if let idStr = UserDefaults.standard.object(forKey: "") as? String {
            return idStr
        }
        return ""
    }
}
