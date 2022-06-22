//
//  FavouriteModule.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 25/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

struct FavouriteModule: Codable {
    
    var id: String?
    var educationLessonId: String?
    var participantId: String?
    var educationLesson: FavEducationLesson?
}

struct FavEducationLesson: Codable {
    
    var id: String?
    var name: String?
    var description: String?
    var imageUrl: String?
    var scheduledTime: String?
    var status: String?
    var pageCount: Int?
    var createdById: String?
}
