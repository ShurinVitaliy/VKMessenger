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
    func presentController(_ controller: UIViewController!)
    func authorizationСompleted()
}

class AuthorizationProviderImp: NSObject, AuthorizationProvider {
    weak var delegate: AuthorizationProviderDelegate?
    private let sdkInstance = VKSdk.initialize(withAppId: "6804688")
    private let scope = ["friends", "email", "notify", "photos", "status", "groups", "messages"]
    override init() {
        super.init()
        sdkInstance?.register(self)
        sdkInstance?.uiDelegate = self
    }
    
    func logIn() -> Void {
        VKSdk.wakeUpSession(scope, complete: {[weak self] (state: VKAuthorizationState, error: Error?) in
            if state != .authorized {
                VKSdk.authorize(self?.scope)
            } else {
                self?.delegate?.authorizationСompleted()
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
        delegate?.presentController(controller)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        delegate?.authorizationСompleted()
    }
}
