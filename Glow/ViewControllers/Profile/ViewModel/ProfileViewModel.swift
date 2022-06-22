//
//  ProfileViewModel.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 01/02/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ProfileViewModel: NSObject {
    
    var firstName: String?
    var lastName: String?
    var dob: String?
    var gender: String?

    func updateUserProfile(complition: @escaping (Bool, String?) -> ()) {
        guard let userId = Glow.sharedInstance.userId else {
            complition(false, nil)
            return
        }
        guard let firstName = firstName, let lastName = lastName, let dob = dob, let gender = gender else {
            complition(true, nil)
            return
        }
        SessionManager.default.requestModel(request: Router.users(userId: userId, firstName: firstName, lastName: lastName, gender: gender, dob: dob).urlRequest()) { (response: SignupResponse?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                if let firstName = response?.firstName {
                    Glow.sharedInstance.firstName = firstName
                    UserDefaults.firstName = firstName
                }
                if let lastName = response?.lastName {
                    Glow.sharedInstance.lastName = lastName
                    UserDefaults.lastName = lastName
                }
                complition(true, nil)
            }
        }
    }
}
