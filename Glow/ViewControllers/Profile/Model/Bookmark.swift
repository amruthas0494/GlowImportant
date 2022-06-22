//
//  Bookmark.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 15/04/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

struct Bookmark: Codable {
    
    var id: String?
    var name: String?
    var imageUrl: String?
    var educationLessonUnits: [BookmarkEducationLessonUnit]?
    
    /*var id: String?
    var educationLessonId: String?
    var educationLessonPageId: String?
    var patientId: String?
    var educationLessonPage: BookmarkEducationLessonPage?
    var educationLesson: BookmarkEducationLesson?*/
}

struct BookmarkEducationLessonUnit: Codable {
    
    var id: String?
    var title: String?
    var imageUrl: String?
    var educationLessonPages: [BookmarkEducationLessonPage]?
}

struct BookmarkEducationLessonPage: Codable {
    
    var id: String?
    var title: String?
    var imageUrl: String?
}

struct BookmarkEducationLesson: Codable {
    
    var id: String?
    var name: String?
    var imageUrl: String?
}
