//
//  UserDefaults+Extension.swift
//  Glow
//
//  Created by Pushpa Yadav on 15/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    private enum Keys {
        
        static let userId = "userId"
        static let email = "email"
        static let userProfile = "userProfile"
        static let firstName = "firstName"
        static let lastName = "lastName"
        
        static let onboardToken = "token"
        static let phoneNo = "PhoneNo"
        static let prefFontSize = "prefFontSize"
        static let unitId = "id"
        static let theme = "theme"
        static let futureSignInOpt = "futureSignInOpt"
        static let lockScreen = "lockScreenPref"
        static let selectedLanguage = "language"
    }
    
    class var prefFontSize: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.prefFontSize)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.prefFontSize)
        }
    }
    class var selectedLanguage: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.selectedLanguage)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.selectedLanguage)
        }
    }
    
    class var onboardToken: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.onboardToken)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.onboardToken)
        }
    }
    
    class var phoneNo: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.phoneNo)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.phoneNo)
        }
    }
    
    class var userId: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.userId)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.userId)
            Glow.sharedInstance.userId = newValue
        }
    }
    class var unitId: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.unitId)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.unitId)
           
        }
    }
    
    class var email: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.email)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.email)
            UserDefaults.standard.synchronize()
        }
    }
    
    class var userProfile: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.userProfile)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.userProfile)
        }
    }
    
    class var firstName: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.firstName)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.firstName)
        }
    }
    
    class var lastName: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.lastName)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.lastName)
        }
    }
    
    class var theme: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.theme)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.theme)
            UserDefaults.standard.synchronize()
        }
    }
    
    class var futureSignInOpt: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.futureSignInOpt)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.futureSignInOpt)
            UserDefaults.standard.synchronize()
        }
    }
    
    class var lockScreen: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.lockScreen)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.lockScreen)
            UserDefaults.standard.synchronize()
        }
    }
    
    func removeAll() {
        UserDefaults.standard.removeObject(forKey: Keys.onboardToken)
        UserDefaults.standard.removeObject(forKey: Keys.prefFontSize)
        UserDefaults.standard.removeObject(forKey: Keys.userId)
        UserDefaults.standard.removeObject(forKey: Keys.email)
        UserDefaults.standard.removeObject(forKey: Keys.firstName)
        UserDefaults.standard.removeObject(forKey: Keys.lastName)
        UserDefaults.standard.removeObject(forKey: Keys.userProfile)
        UserDefaults.standard.removeObject(forKey: Keys.phoneNo)
        UserDefaults.standard.removeObject(forKey: Keys.theme)
        UserDefaults.standard.removeObject(forKey: Keys.lockScreen)
        UserDefaults.standard.synchronize()
    }
}
