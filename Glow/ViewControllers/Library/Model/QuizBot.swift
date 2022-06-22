//
//  QuizBot.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 08/03/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

struct BotResponse: Codable {
    var bots: [Bot]?
    var count: Int?
}

struct Bot: Codable {
    var id: String?
    var name: String?
    var status: String?
    var scheduledOn: String?
    var creator: Creator?
}

struct Creator: Codable {
    var id: String?
    var firstName: String?
    var lastName: String?
    var role: String?
}
