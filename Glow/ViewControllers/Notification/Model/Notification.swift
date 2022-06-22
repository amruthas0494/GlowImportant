//
//  Notification.swift
//  Glow
//
//  Created by Cognitiveclouds on 05/06/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation


// MARK: - NotificationList
struct NotificationList: Codable {
    let statusCode: Int?
    let data: NotificationData
    let message: String?

    enum CodingKeys: String, CodingKey {
        case statusCode
        case data
        case message
    }
}

struct NotificationData: Codable {
    let count: Int?
    let unreadCount: Int?
    let notifications: [Notifications]

    enum CodingKeys: String, CodingKey {
        case count
        case unreadCount
        case notifications
    }
}

struct Notifications: Codable {
    let title: String?
    let body: String?
    let createdAt:String?
    let createdBy:String?
    let data: educationlessonDetails
    let deteledAt:String?
    let eventId:String?
    let id: String?
    let imageUrl: String?
    let isRead:Bool
    let userId:String?
 

    enum CodingKeys: String, CodingKey {
        case title
        case body
        case createdAt
        case createdBy
        case data
        case deteledAt
        case eventId
        case id
        case imageUrl
      case isRead
        case userId
       
    }
}

struct educationlessonDetails: Codable {
    let educationLessonId: String?
    let eventId: String?
    let imageUrl: String?

   

    enum CodingKeys: String, CodingKey {
        case educationLessonId
        case eventId
        case imageUrl
       
    }
}


// MARK: - Read notifications

struct ReadNotifications: Codable {
    let id, title, body: String
    let imageURL: String?
    let isRead: Bool
    let eventID: String
    let data: ReadData
    let userID, createdAt, updatedAt: String
    let deletedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, title, body
        case imageURL = "imageUrl"
        case isRead
        case eventID = "eventId"
        case data
        case userID = "userId"
        case createdAt, updatedAt, deletedAt
    }
}

// MARK: - DataData
struct ReadData: Codable {
    let eventID, educationLessonID: String

    enum CodingKeys: String, CodingKey {
        case eventID = "eventId"
        case educationLessonID = "educationLessonId"
    }
}





// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


