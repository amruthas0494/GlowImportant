//
//  LogOutViewModel.swift
//  Glow
//
//  Created by Suman Reshma J on 20/06/22.
//  Copyright © 2022 CC. All rights reserved.
//

import SwiftKeychainWrapper

class LogOutViewModel: NSObject {
    
    var fcmToken: String?
    
    func logOut(complition: @escaping (Bool, String?) -> ()) {
        guard let fcmToken = fcmToken else { return }
        SessionManager.default.requestModel(request: Router.logOut(fcmToken: fcmToken).urlRequest()) { (response: LogOutResponse?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                complition(true, nil)
                print(response)
            }
        }
    }
}

struct LogOutResponse: Codable {
    let statusCode: Int?
    let data: Logout?
    let message: String?
}

struct Logout: Codable {
}
