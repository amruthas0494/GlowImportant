//
//  ReflectionJournal.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 04/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let statusCode: Int
    let data: DataClass
    let message: String

    
}
    // MARK: - DataClass
    struct DataClass: Codable {
        let id: String
        let value: String
        let numberValue: String?
        let educationLessonID: String
        let educationLessonUnitID: String
        let participantID: String
        let createdAt: String
        let updatedAt: String
        let deletedAt: String?

        enum CodingKeys: String, CodingKey {
            case id
            case value
            case numberValue
            case educationLessonID
            case educationLessonUnitID
            case participantID
            case createdAt
            case updatedAt
            case deletedAt
        }
    }
// MARK: - ReflectionById
struct ReflectionById: Codable {
    let statusCode: Int?
    let data: ReflectionJornal?
    let message: String?

}

// MARK: - ReflectionJornal
struct ReflectionJornal: Codable {
    
    var id: String?
    var unitId: String?
    var value: String?
    var numberValue: Int?
    var educationLessonId: String?
    var participantId: String?
}

struct ReflectionJournal: Codable {
    
    var id: String?
    var name: String?
    var description: String?
    var scheduledTime: String?
    var status: String?
    var pageCount: Int?
    var imageUrl: String?
    var units: [ReflectionUnit]?
}

struct ReflectionUnit: Codable {
    
    var id: String?
    var title: String?
    var description: String?
    var journal: Journal?
}

struct Journal: Codable {
    
    var id: String?
    var value: String?
}

