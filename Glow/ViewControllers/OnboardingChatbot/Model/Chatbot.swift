//
//  Chatbot.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 03/03/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

struct ChatbotResponse: Codable {
    var prevStep: ChatbotStep?
    var currentStep: ChatbotStep?
    var nextStep: ChatbotStep?
    var status: String?
}

struct ChatbotStep: Codable {
    var id: String?
    var name: String?
    var type: String?
    var position: Int?
    var codeName: String?
    var ref: String?
    var botId: String?
    var stepOptions: [StepOption]?
    var stepMessages: [StepMessage]?
    var stepSettings: StepSetting?
    var response: Response?
    var stepResponse: StepResponse?
}

struct StepOption: Codable {
    var id: String?
    var text: String?
    var subText: String?
    var position: Int?
    var imageUrl: String?
    var ref: String?
    var botStepId: String?
}

struct StepMessage: Codable {
    var id: String?
    var text: String?
    var type: String?
    var position: Int?
    var delay: Int? //miliseconds
    var attachmentUrl: String?
    var botStepId: String?
}

struct StepSetting: Codable {
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
}

struct StepResponse: Codable {
    var id: String?
    var isDefault: Bool?
    var exitAfter: Bool?
    var botStepId: String?
    var nextStepId: String?
    var stepOptionId: String?
    var stepResponseMessages: [StepResponseMessages]?
}

struct StepResponseMessages: Codable {
    var id: String?
    var text: String?
    var type: String?
    var position: Int?
    var delay: Int?
    var attachmentUrl: String?
    var stepResponseId: String?
    var educationLessonId: String?
    var educationLessonUnitId: String?
    var educationLessonPageId: String?
    var educationLesson: BotEducationLesson?
    var educationLessonUnit: Unit?
    var educationLessonPage: EducationLessonPage?
}

struct BotEducationLesson: Codable {
    var imageUrl: String?
    var id: String?
    var name: String?
    var description: String?
    var scheduledTime: String?
    var status: String?
    var pageCount: Int?
}

struct EducationLessonPage: Codable {
    var imageUrl: String?
    var id: String?
    var title: String?
    var position: Int?
    var educationLessonUnitId: String?
}

struct PreviousStepResponse: Codable {
    var prevSteps: [ChatbotStep]?
}
