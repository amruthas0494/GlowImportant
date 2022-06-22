//
//  LessonReview.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 04/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

struct LessonReview: Codable {
    
    var id: String?
    var rating: Int?
    var review: String?
    var suggestion: String?
    var educationLessonId: String?
    var participantId: String?
}
