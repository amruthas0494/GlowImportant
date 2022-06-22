//
//  AppUserManager.swift
//  Skylor
//
//  Created by Harsha on 10/14/19.
//  Copyright © 2019 Skylor Lane. All rights reserved.
//

import Foundation

class AppUserManager {
    
//    static func fetchUser() -> User? {
//        return AppSettings.retrieve(object: User.self, fromKey: AppConstant.user.rawValue)
//    }
//    static func fetchDeletedTipId() -> [String] {
//        return AppSettings.arrayValue(forKey: AppConstant.deletedTipId.rawValue ) ?? [""]
//       
//    }
//    static func fetchAllLoggedInUser() -> [String] {
//        return AppSettings.arrayValue(forKey: AppConstant.deletedTipId.rawValue ) ?? [""]
//    }
//    static func fetchAllLoggedUsedId() -> [String] {
//        return AppSettings.arrayValue(forKey: AppConstant.loggedUserId.rawValue ) ?? [""]
//    }
//    
//    static func removeTip() {
//        for id in fetchDeletedTipId() {
//           AppSettings.removeStringValue(AppConstant.deletedTipId.rawValue)
//           AppSettings.removeObjectValue(AppConstant.deletedTipId.rawValue)
//        }
//      AppSettings.removeStringValue(AppConstant.deletedTipId.rawValue)
//       AppSettings.removeObjectValue(AppConstant.deletedTipId.rawValue)
//       
//    }
    
    
   static func removeUser() {
        AppSettings.removeObjectValue(AppConstant.user.rawValue)
     }
    static func isFingerAuthEnabled() -> Bool {
        return AppSettings.booleanValue(forKey: AppConstant.fingerAuth.rawValue)
    }
    static func removeFingerAuth() {
           AppSettings.removeObjectValue(AppConstant.fingerAuth.rawValue)
        }
}
