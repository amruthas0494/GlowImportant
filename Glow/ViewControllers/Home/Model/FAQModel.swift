//
//  FAQModel.swift
//  Glow
//
//  Created by Cognitiveclouds on 02/06/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation
// MARK: - FAQModel
struct FAQModel: Codable {
    let statusCode: Int?
    let data: FAQData
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case data
        case message
    }
}



// MARK: - DataClass
struct FAQData: Codable {
    let id: String?
    let name: String?
    let status: String?
    let scheduledOn: String?
    let updatedOn: String?
    let type: String?
    let creatorId: String?
    let lastModifierId: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
    let botSteps: [BotStep]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case scheduledOn
        case updatedOn
        case type
        case creatorId
        case lastModifierId
        case createdAt
        case updatedAt
        case deletedAt
        case botSteps
    }
}

// MARK: - BotStep
struct BotStep: Codable {
    let id: String
    let name: String
    let type: String
    let position: Int
    let codeName: String
    let ref: String
    let botId: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
   
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case position
        case codeName
        case ref
        case botId
        case createdAt
        case updatedAt
        case deletedAt
    }
}


// MARK: - FAQStatus
struct FAQStatus: Codable {
    let statusCode: Int
    let data: CurrentStep
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case data
        case message
    }
}
//
//// MARK: - DataClass
//struct FAQSteps: Codable {
//    let prevStep: CurrentStep?
//    let currentStep: CurrentStep?
//    let nextStep: CurrentStep?
//    let status: String
//
//    enum CodingKeys: String, CodingKey {
//        case prevStep
//        case currentStep
//        case nextStep
//        case status
//    }
//}

// MARK: - CurrentStep
struct CurrentStep: Codable {
    let id: String
    let name: String
    let type: String
    let position: Int
    let codeName: String
    let ref: String
    let botId: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
    var stepSettings: String?
    var response:Response?
    var stepResponses: [StepResponse]?
    let options: [StepOption]
    let botMessages: [StepMessage]?
 
   
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case position
        case codeName
        case ref
        case botId
        case createdAt
        case updatedAt
        case deletedAt
        case stepSettings
              case stepResponses
              case botMessages
              case options
    }
}

// MARK: - BotMessage
struct BotMessage: Codable {
    let id: String?
    let text: String?
    let type: String?
    let position: Int?
    let delay: Int?
    let attachmentUrl: String?
    let botStepId: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case type
        case position
        case delay
        case attachmentUrl
        case botStepId
        case createdAt
        case updatedAt
        case deletedAt
    }
}

// MARK: - Options
struct Options: Codable {
    let id: String?
    let text: String?
    let subText: String?
    let position: Int?
    let imageUrl: String?
    let ref: String?
    let botStepId: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt:String?

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case subText
        case position
        case imageUrl
        case ref
        case botStepId
        case createdAt
        case updatedAt
        case deletedAt
    }
}


// MARK: - StepMessage
struct StepMessages: Codable {
    let id: String
    let text: String
    let type: String
    let position: Int
    let delay: Int
    let attachmentUrl: String?
    let botStepId: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case type
        case position
        case delay
        case attachmentUrl
        case botStepId
        case createdAt
        case updatedAt
        case deletedAt
    }
}
struct Responses: Codable {
    var id: String?
    var textValue: String?
    var numberValue: Double?
    var dateValue: String?
    var position: Int?
    var timeTaken: Int?
    var responseCode: Int?
    var version: Int?
    var botStepId: String?
    var botId: String?
    var stepOptionId: String?
    let participantId: String?
}

// MARK: - StepOption
struct StepOptions: Codable {
    let id: String
    let text: String
    let subText: String?
    let position: Int
    let imageUrl: String?
    let ref: String
    let botStepId: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case subText
        case position
        case imageUrl
        case ref
        case botStepId
        case createdAt
        case updatedAt
        case deletedAt
    }
}
/*struct StepSetting: Codable {
 var id: String?
 var minValue: Int?
 var maxValue: Int?
 var defaultValue: Int?
 var leftLabel: String?
 var rightLabel: String?
 var unit: String?
 var stepSize: Int?
 var botStepId: String?
 }
 
 struct Response: Codable {
 var id: String?
 var textValue: String?
 var numberValue: Double?
 var dateValue: String?
 var position: Int?
 var timeTaken: Int?
 var responseCode: Int?
 var version: Int?
 var botStepId: String?
 var botId: String?
 var stepOptionId: String?
 let participantId: String?
 }
 
 struct SubmitResponse: Codable {
 var id: String?
 var botId: String?
 var botStepId: String?
 var participantId: String?
 var position: Int?
 var responseCode: String?
 var stepOptionId: String?
 var textValue: String?
 var dateValue: String?
 var numberValue: Double?
 var timeTaken: Int?
 }*/

// MARK: - StepResponse
struct StepResponses: Codable {
    let id: String
    let isDefault: Bool
    let exitAfter: Bool
    let stepResponseOperator: JSONNull?
    let compareText: JSONNull?
    let compareDate: JSONNull?
    let compareNumber: JSONNull?
    let botStepId: String
    let nextStepId: String?
    let stepOptionId: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
    let stepResponseMessages: [StepResponseMessage]
    let nextStep: nextStep?
    let stepOption: Options
   // let operator : String?

    enum CodingKeys: String, CodingKey {
        case id
        case isDefault
        case exitAfter
        case stepResponseOperator
        case compareText
        case compareDate
        case compareNumber
        case botStepId
        case nextStepId
        case stepOptionId
        case createdAt
        case updatedAt
        case deletedAt
        case stepResponseMessages
        case nextStep
        case stepOption
    }
}

// MARK: - nextStep
struct nextStep: Codable {
    let id: String?
    let name: String?
    let type: String?
    let position: Int?
    let codeName: String?
    let ref: String?
    let botId: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
   
    

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case position
        case codeName
        case ref
        case botId
        case createdAt
        case updatedAt
        case deletedAt
    }
}

// MARK: - StepResponseMessage
struct StepResponseMessage: Codable {
    let id: String
    let text: JSONNull?
    let type: String
    let position: Int
    let delay: Int
    let attachmentUrl: JSONNull?
    let stepResponseId: String
    let educationLessonId: JSONNull?
    let educationLessonUnitId: JSONNull?
    let educationLessonPageId: JSONNull?
    let botId: String
    let botStepId: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: JSONNull?
    let educationLesson: JSONNull?
    let educationLessonUnit: JSONNull?
    let educationLessonPage: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id
        case text
        case type
        case position
        case delay
        case attachmentUrl
        case stepResponseId
        case educationLessonId
        case educationLessonUnitId
        case educationLessonPageId
        case botId
        case botStepId
        case createdAt
        case updatedAt
        case deletedAt
        case educationLesson
        case educationLessonUnit
        case educationLessonPage
    }
}

// MARK: - PreviewFAQResponse
struct PreviewFAQResponse: Codable {
    let statusCode: Int?
    let data: PreviewData
    let message: String?

    enum CodingKeys: String, CodingKey {
        case statusCode
        case data
        case message
    }
}
// MARK: - DataClass
struct PreviewData: Codable {
    let currentStep: ChatbotStep?
    let status: String?
    let prevStep: PrevStep
    

    enum CodingKeys: String, CodingKey {
        case currentStep
        case status
        case prevStep
    }
}
// MARK: - PrevStep
struct PrevStep: Codable {
    let id: String?
    let isDefault: Bool?
    let exitAfter: Bool?
    let prevStepOperator: JSONNull?
    let compareText: JSONNull?
    let compareDate: JSONNull?
    let compareNumber: JSONNull?
    let botStepID: String?
    let nextStepID: JSONNull?
    let stepOptionID: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: JSONNull?
    let stepResponseMessages: [StepResponseMessage]

    enum CodingKeys: String, CodingKey {
        case id
        case isDefault
        case exitAfter
        case prevStepOperator
        case compareText
        case compareDate
        case compareNumber
        case botStepID
        case nextStepID
        case stepOptionID
        case createdAt
        case updatedAt
        case deletedAt
        case stepResponseMessages
    }
}



struct PreviousFAQStepResponse: Codable {
    var prevSteps: [CurrentStep]?
}
