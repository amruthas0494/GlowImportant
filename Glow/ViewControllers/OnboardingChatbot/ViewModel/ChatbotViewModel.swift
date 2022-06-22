//
//  ChatbotViewModel.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 03/03/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

enum BotMessageType: String {
    case text = "text",
         image = "image",
         video = "video",
         link = "link",
        Bot = "bot",
        educationLesson = "educationLesson"
         
}

enum BotOptionType: String {
    case multipleChoice = "multiple_choice",
         shortText = "short_text",
         longText = "long_text",
         yesNo = "yes_no",
         number = "number",
         calendar = "calendar",
         slider = "slider",
         typing = "typing",
         textView = "textView",
         rightTextView = "rightTextView",
         status = "status"
         
      
}

class ChatbotViewModel: NSObject {
    
    var chatbotId: String?
    var faqbotId: String?
    var botstatus:String?
    
    //Current step
    var stepId: String?
    var stepType: BotOptionType = .typing
    var previousStep: ChatbotStep?
    var currentStep: ChatbotStep?
    var currentStep1: CurrentStep?
    var faqTpics:FAQData?
    var faqSteps:CurrentStep?
    var value: String?
    var timeTaken: Int = 0
    
    func getPreviousStep(completion: @escaping (Bool, String?, PreviousStepResponse?) -> ()) {
        
        guard let chatbotId = self.chatbotId else {
            completion(false, "Bot id missing.", nil)
            return
        }
        SessionManager.default.requestModel(request: Router.previousStep(botId: chatbotId).urlRequest())
        {(result: PreviousStepResponse?, error: GlowError?) in
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
    
    func getCurrentStep(completion: @escaping (Bool, String?, ChatbotResponse?)->()) {
        
        guard let chatbotId = chatbotId else {
            completion(false, "Missing bot id.", nil)
            return
        }
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
                self.botstatus = result?.status
                self.currentStep = result?.currentStep
                self.stepId = result?.currentStep?.id
                self.stepType = BotOptionType(rawValue: result?.currentStep?.type ?? "") ?? .typing
                completion(true, nil, result)
            }
        }
    }
    
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
    }
    
    func previewNextStep(completion: @escaping (Bool, String?, PreviewData?)->()) {
        
        guard let botId = self.faqbotId, let stepId = stepId else {
            completion(false, "No step id found.", nil)
            return
        }
        guard let value = value else {
            completion(false, "No value submitted", nil)
            return
        }
        let response = self.preparePostRequest(value: value)
        SessionManager.default.requestModel(request: Router.previewNextStep(botId: botId, botStepId: stepId, stepType: self.stepType.rawValue, response: response).urlRequest()) { (result: PreviewData?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err, nil)
                case .none:
                    completion(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
                print(result)
                self.currentStep = result?.currentStep
                //self.previousStep = result?.prevStep
                completion(true, nil, result)
                
            }
        }
       
    }
    
    func getFAQAllSteps(completion: @escaping (Bool, String?, FAQData?) -> ()) {
     
        SessionManager.default.requestModel(request: Router.getFAQTopics.urlRequest())
        {(result: FAQData?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err, nil)
                case .none:
                    completion(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
                self.faqTpics = result
                self.faqbotId = result?.id
                self.chatbotId = result?.id
                self.stepId = result?.botSteps.first?.id
                print("id",self.faqbotId)
                completion(true, nil, result)
            }
        }
    }
    func getCurrentStepFAQ(completion: @escaping (Bool, String?, ChatbotResponse?)->()) {
        
//        guard let chatbotId = chatbotId else {
//            completion(false, "Missing bot id.", nil)
//            return
//        }
        SessionManager.default.requestModel(request: Router.currentStep(botId: self.chatbotId ?? "").urlRequest())
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
    

    
   
   /*
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
              // self.previousStep = result?.prevStep
//               self.currentStep = result?.currentStep
//                self.stepId = result?.currentStep?.id
//                self.stepType = BotOptionType(rawValue: result?.currentStep?.type ?? "") ?? .typing
                completion(true, nil, result)
            }
        }
    }*/
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
    
    
    func getStepData(completion: @escaping (Bool, String?, CurrentStep?)->()) {
        
        guard let stepId = self.stepId else {
            completion(false, "No step id found.", nil)
            return
        }
        
        SessionManager.default.requestModel(request: Router.getStepById(stepId: stepId).urlRequest())
        {(result: CurrentStep?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err, nil)
                case .none:
                    completion(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
                print(result)
               
                self.stepType = BotOptionType(rawValue: result?.type ?? "") ?? .typing
                completion(true, nil, result)
            }
        }
    }
    
}
