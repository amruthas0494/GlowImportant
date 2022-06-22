//
//  LoginViewModel.swift
//  Glow
//
//  Created by Nidhishree HP on 29/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import SwiftKeychainWrapper

class LoginViewModel: NSObject {
    
    var email: String?
    var password: String?
    var phoneNo: String?
    var fcmToken: String?
    
    func login(complition: @escaping (Bool, String?) -> ()) {
        guard let email = email, let password = password, let fcmToken = fcmToken else { return }
        SessionManager.default.requestModel(request: Router.login(userName: email.lowercased(), password: password, fcmToken: fcmToken).urlRequest()) { (response: SignupResponse?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                if let userId = response?.id {
                    Glow.sharedInstance.userId = userId
                    UserDefaults.userId = userId
                }
                if let firstName = response?.firstName {
                    Glow.sharedInstance.firstName = firstName
                    UserDefaults.firstName = firstName
                }
                if let lastName = response?.lastName {
                    Glow.sharedInstance.lastName = lastName
                    UserDefaults.lastName = lastName
                }
                if let imageProfile = response?.profileImage {
                    Glow.sharedInstance.imageProfile = imageProfile
                    UserDefaults.userProfile = imageProfile
                }
                if let email = response?.email {
                    UserDefaults.email = email
                }
                if let token = response?.token {
                    KeychainWrapper.standard.set(token, forKey: Constant.loginConstants.authToken)
                }
                complition(true, nil)
            }
        }
    }
    
    func forgotPassword(complition: @escaping (Bool, String?) -> ()) {
        guard let email = email else {
            return
        }
        SessionManager.default.requestModel(request: Router.forgotPassword(email: email.lowercased()).urlRequest()) { (result: SignupResponse?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                complition(true, nil)
            }
        }
    }
    
    func resendOTP(complition: @escaping (Bool, String?) -> ()) {
        guard let phoneNo = phoneNo else {
            return
        }
        SessionManager.default.requestModel(request: Router.resendOTP(phoneNo: phoneNo).urlRequest()) { (result: SignupResponse?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                complition(true, nil)
            }
        }
    }
}

struct SignupResponse: Codable {
    var id: String?
    var token: String?
    var email: String?
    var phoneNumber: String?
    var firstName: String?
    var lastName: String?
    var status: String?
    var profileImage: String?
    var dbToken: String?
    var role: String?
}
