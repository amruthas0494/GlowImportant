//
//  File.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 05/05/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

struct ModuleSummary: Codable {
    
    var summary: String?
    var unitProgresses: [UnitProgress]?
}

struct UnitProgress: Codable {
    
    var id: String?
    var participantId: String?
    var educationLessonId: String?
    var educationLessonUnitId: String?
    var startedAt: String?
    var completedAt: String?
    var educationLessonUnit: EducationLessonUnit?
}

struct EducationLessonUnit: Codable {
    
    var webUrl: String?
    var id: String?
    var title: String?
    var description: String?
    var imageUrl: String?
    var position: Int?
    var educationLessonId: String?
}
