//
//  Glow.swift
//  Glow
//
//  Created by Pushpa Yadav on 13/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import Foundation

class Glow {
    
    static let sharedInstance = Glow()
    
    var prefFontSize: Int = 0
    var userId: String?
    var firstName: String?
    var lastName: String?
    var imageProfile: String?
    var token: String?
    var language : String?
    
    init() {
        prefFontSize = UserDefaults.prefFontSize
        language = UserDefaults.selectedLanguage

        self.userId = UserDefaults.userId
        self.firstName = UserDefaults.firstName
        self.lastName = UserDefaults.lastName
        self.imageProfile = UserDefaults.userProfile
    }
  
}
