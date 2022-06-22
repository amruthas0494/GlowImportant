
//  Service.swift
//  Skylor
//
//  Created by Harsha on 30/07/19.
//  Copyright © 2019 Skylor Lane. All rights reserved.
//

import UIKit

//enum Request: RequestProtocol {
//    
//    case signUp(phoneNumber: String, password: String)
//    case logIn(phoneNumber: String)
//    case fbTokenAdd(token: String)
//    case userDetail(name: String, age: String, profession: String)
//    
//    
//  
//    static var baseURL: String { return "https://hero-stg-be-7m4wybox7a-as.a.run.app/" }
//    var path: String {
//        let id = AppUserManager.fetchUser()?.id ?? -1
//        switch self {
//        case .signUp: return "/v1/signup"
//        case .logIn(let _): return "api/login/"
//        case .fbTokenAdd(let token): return "api/userfirebasetokenadd/"
//        case .userDetail(let name, let age, let profession): return "api/user/"
//       
//        }
//    }
//    
//    var task: Task {
//        var parameters = [String: Any]()
//        let id = AppUserManager.fetchUser()?.id ?? -1
//        switch self {
//      
//        case .signUp(let phoneNumber, let password):
//            return .requestParameters(parameters)
//        
//        case .logIn(let phoneNumber):
//            parameters["phone"] = id
//            return .requestParameters(parameters)
//            
//        case .fbTokenAdd(let token):
//             parameters["firebase_token"] = token
//            return .requestParameters(parameters)
//            
//        case .userDetail(let name, let age, let profession):
//            parameters["name_title"] = name
//            parameters["age"] = age
//            parameters["profession"] = profession
//            return .requestParameters(parameters)
//            
//       
//        
//        }
//    }
//    var method: HTTPMethod {
//        switch self {
//        case .signUp,.logIn, .fbTokenAdd,.userDetail: return .post
//        
//        
//        }
//    }
//    
//    var headers: Headers? {
//        var headers = Headers()
//        headers["Content-Type"] = "application/json"
//        headers["platForm"] = "iOS"
//        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
//            headers["appVersion"] = version
//        }
//        headers["Content-Type"] = "application/json"
//        if let token = AppSettings.stringValue(forKey: AppConstant.token.rawValue) {
//            headers["Authorization"] = "Bearer \(token)"
//        } else{
//            print("token is nil")
//        }
//        if let fcmToken = AppSettings.stringValue(forKey: AppConstant.fcmToken.rawValue) {
//            headers["deviceToken"] = "\(fcmToken)"
//        }
//        
//        if let voipToken = AppSettings.stringValue(forKey: AppConstant.voipToken.rawValue) {
//            headers["voipToken"] = "\(voipToken)"
//        }
//
//        switch self {
//        case .signUp, .logIn, .fbTokenAdd,.userDetail: return headers
//        }
//    }
//    
//    var parametersEncoding: ParametersEncoding {
//        switch self {
//        case .signUp, .logIn, .fbTokenAdd, .userDetail: return .json
//        
//    }
//    }
//}

extension NSMutableData {
    public func appendString(string: String) {
        if let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true) {
            append(data)
        }
    }
}
