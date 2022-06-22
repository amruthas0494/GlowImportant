//
//  EducationLesson.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 03/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

struct EducationLessonList: Codable {
    var id: String?
    var name: String?
    var description: String?
    var lessonCount: Int?
    var createdAt: String?
    var updatedAt: String?
    var educationLessons: [EducationLesson]?
}

struct EducationLesson: Codable {
    var id: String?
    var imageUrl: String?
    var name: String?
    var description: String?
    var status: String?
    var pageCount: Int?
    var participantCompletedUnit: Int?
    var favourites: [Favourite]?
}

struct Favourite: Codable {
    var id: String
}
