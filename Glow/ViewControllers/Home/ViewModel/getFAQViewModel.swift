//
//  getFAQViewModel.swift
//  Glow
//
//  Created by Cognitiveclouds on 02/06/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation
enum FAQMessageType: String {
    case text = "text",
         image = "image",
         video = "video"
}

enum FAQOptionType: String {
    case multipleChoice = "multiple_choice",
         shortText = "short_text",
         longText = "long_text",
         yesNo = "yes_no",
         number = "number",
         calendar = "calendar",
         slider = "slider",
         typing = "typing",
         textView = "textView",
         rightTextView = "rightTextView"
}

class getFAQViewModel: NSObject {
    
    var faqbotId: String?
    
    //Current step
    var stepId: String?
    var stepType: BotOptionType = .typing
    var previousStep: CurrentStep?
    var currentStep: CurrentStep?
    var faqTpics:FAQModel?
    
    var value: String?
    var timeTaken: Int = 0
    
    func getFAQAllSteps(completion: @escaping (Bool, String?, FAQModel?) -> ()) {
     
        SessionManager.default.requestModel(request: Router.getFAQTopics.urlRequest())
        {(result: FAQModel?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err, nil)
                case .none:
                    completion(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
                self.faqTpics = result
                self.faqbotId = result?.data.id
                completion(true, nil, result)
            }
        }
    }
    
    func getPreviousStep(completion: @escaping (Bool, String?, PreviousFAQStepResponse?) -> ()) {
        
       
        SessionManager.default.requestModel(request: Router.previousStep(botId: faqbotId ?? "5e596739-fa88-461b-b9ee-8dd1770b2f2e").urlRequest())
        {(result: PreviousFAQStepResponse?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err, nil)
                case .none:
                    completion(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
                completion(true, nil, result)
            }
        }
    }
    
    func preparePostRequest(value: String) -> [String: Any?] {
        
        switch self.stepType {
        case .multipleChoice, .yesNo:
            return ["stepOptionId": value, "textValue": nil, "numberValue": nil, "dateValue": nil]
        case .shortText, .longText://, .yesNo:
            return ["stepOptionId": nil, "textValue": value, "numberValue": nil, "dateValue": nil]
        case .number, .slider:
            return ["stepOptionId": nil, "textValue": nil, "numberValue": Double(value) ?? 0, "dateValue": nil]
        case .calendar:
            return ["stepOptionId": nil, "textValue": nil, "numberValue": nil, "dateValue": value]
        default:
            return [:]
        }
    }
    
    func getCurrentStepFAQ(completion: @escaping (Bool, String?, PreviousFAQStepResponse?)->()) {
        
     
        SessionManager.default.requestModel(request: Router.currentStep(botId: self.faqbotId ?? "5e596739-fa88-461b-b9ee-8dd1770b2f2e").urlRequest())
        {(result: PreviousFAQStepResponse?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err, nil)
                case .none:
                    completion(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
//               self.previousStep = result?.prevStep
//               self.currentStep = result?.currentStep
//                self.stepId = result?.currentStep?.id
//                self.stepType = BotOptionType(rawValue: result?.currentStep?.type ?? "") ?? .typing
                completion(true, nil, result)
            }
        }
    }
  /*
    func getCurrentStep(completion: @escaping (Bool, String?, FAQSteps?)->()) {
     
        SessionManager.default.requestModel(request: Router.currentStep(botId: chatbotId).urlRequest())
        {(result: ChatbotResponse?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err, nil)
                case .none:
                    completion(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
                self.previousStep = result?.prevStep
                self.currentStep = result?.currentStep
                self.stepId = result?.currentStep?.id
                self.stepType = BotOptionType(rawValue: result?.currentStep?.type ?? "") ?? .typing
                completion(true, nil, result)
            }
        }
    }
    */
    
    
    func getStepData(stepid: String, completion: @escaping (Bool, String?, SubmitResponse?)->()) {
        
       
        
        SessionManager.default.requestModel(request: Router.getStepById(stepId: stepId ?? "").urlRequest())
        {(result: SubmitResponse?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err, nil)
                case .none:
                    completion(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
                completion(true, nil, result)
            }
        }
    }
   /*
    func postStepData(completion: @escaping (Bool, String?)->()) {
        
        guard let botId = self.chatbotId, let stepId = stepId else {
            completion(false, "No step id found.")
            return
        }
        guard let value = value else {
            completion(false, "No value submitted")
            return
        }
        let response = self.preparePostRequest(value: value)
        SessionManager.default.requestModel(request: Router.submitBotResponse(botId: botId, botStepId: stepId, stepType: self.stepType.rawValue, response: response, timeTaken: self.timeTaken).urlRequest())
        {(result: SubmitResponse?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err)
                case .none:
                    completion(false, DEFAULT_API_ERROR())
                }
            } else {
                completion(true, nil)
            }
        }
    }*/
   
}
