//
//  Unit.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 03/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

struct Unit: Codable {
    
    var id: String?
    var title: String?
    var description: String?
    var imageUrl: String?
    var position: Int?
    var educationLessonId: String?
    var webUrl: String?
    let inputText: String?
    let sliderText: String?
    let initBotId: String?
    let createdAt, updatedAt: String?
    let deletedAt: JSONNull?
    let initBot: InitBot?
    let progress: Progress?
}


// MARK: - InitBot
struct InitBot: Codable {
    let id, name: String?
}

struct Progress: Codable{
    let startedAt, completedAt: String?
}
