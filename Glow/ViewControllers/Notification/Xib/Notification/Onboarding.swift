//
//  Onboarding.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 07/02/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

struct Onboarding: Codable {
    
    var completed: Bool?
    var step: Step?
    
    var success: Bool?
    var next: Bool?
    var data: OnboardingData?
}

struct Step: Codable {
    
    var step: String?
    var action: String?
    var redirectTo: String?
    var messages: [Message]?
    var options: [Option]?
}

struct Message: Codable {
    
    var id: Int?
    var text: String?
    var type: String?
}

struct Option: Codable {
    
    var id: Int?
    var text: String?
    var type: String?
    var redirectTo: String?
}

//struct OnboardingProgress: Codable {
//    
//    var success: Bool?
//    var step: Step?
//    var next: Bool?
//    var data: OnboardingData?
//}

struct OnboardingData: Codable {
    
    // sign up
    var token: String?
    
    // sign in
    var id: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var phoneNumber: String?
    var profileImage: String?
    var role: String?
    var status: String?
}


