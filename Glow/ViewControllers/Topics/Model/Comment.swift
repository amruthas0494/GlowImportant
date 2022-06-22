//
//  Comment.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 05/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

struct CommentData: Codable {
    
    var count: Int?
    var rows: [Comment]?
}

struct Comment: Codable {
    
    var id: String?
    var comment: String?
    var educationLessonId: String?
    var createdAt: String?
    var commenter: Commenter?
}

struct Commenter: Codable {
    
    var firstName: String?
    var lastName: String?
    var profileImage: String?
}
