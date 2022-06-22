//
//  OnboardingChatbotViewModel.swift
//  Glow
//
//  Created by Pushpa Yadav on 10/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import Foundation

// MARK: - Steps
enum OnboardingStep: String {
    case typing = "typing",rightTextView = "rightTextView", themeSelect = "themeSelect", fontSelect = "fontSelect", fontPreview = "fontPreview", intro = "intro", createAccount = "createAccount", login = "login", forgotPassword = "forgotPassword", phoneVerifyInit = "phoneVerifyInit", phoneVerifyCheck = "phoneVerifyCheck", futureSignInOpt = "futureSignInOpt",studyNumber = "studyNumber" ,inputFullName = "inputFullName", inputNickName = "inputNickName", genderSelect = "genderSelect", ethniticySelect = "ethniticySelect", inputDOB = "inputDOB",  describeYourself = "describeYourself", typeOneDiabetesSelect = "typeOneDiabetesSelect", inputPatientName = "inputPatientName" ,diabetesTypeSelect = "diabetesTypeSelect", diabetesConditionSelect = "diabetesConditionSelect", diabetesDiscoverySelect = "diabetesDiscoverySelect", studyGoalSelect = "studyGoalSelect",learningInterestScaleMore = "learningInterestScaleMore", improvementChangeSelect = "improvementChangeSelect",improvementChangeSelectNull = "improvementChangeSelectNull", learningReadinessScale = "learningReadinessScale", learningInterestScale = "learningInterestScale", diabeticChildrenChancesSelect = "diabeticChildrenChancesSelect", notFound = "", optNotification = "optNotification", optNotificationYes = "optNotificationYes", optNotificationNo = "optNotificationNo", optNotificationSlotSetUp = "optNotificationSlotSetUp", personalizeContent = "personalizeContent" , personalizeContentSetup = "personalizeContentSetup", letsBegin = "letsBegin", learningInterestScaleLess = "learningInterestScaleLess"
}

// MARK: - Cell type
enum ChatbotCell: String {
    case typing = "typing", textView = "text", rightTextView = "rightTextView", button = "button", signUpForm = "signUpForm", imageWithText = "textWithImage", studyNumber = "studyNumber", mobileVerify = "mobileVerify", otpVerify = "otp", fullName = "fullName", calledName = "nickName", genderSelection = "gender", datePicker = "date", slider = "scale", inputDOB = "inputDOB", diabetesDiscoverySelect = "age",personalProgram = "personalProgram", login = "login", forgotPassword = "forgotPassword", readingFontSize = "fontSelect", none = "none", learningInterestScaleMore = "learningInterestScaleMore", personalizeContentSetup = "success", letsBegin = "letsBegin", learningInterestScaleLess = "learningInterestScaleLess", optNotificationNo = "optNotificationNo", optNotificationSlotSetUp = "optNotificationSlotSetUp", personalizeContent = "personalizeContent"
}
// typeOneDiabetesSelect = "typeOneDiabetesSelect"
// MARK: - Chat cell data
//typealias chatContent = (text: String, type: ChatbotCell, redirectTo: String?, time: String?)
typealias chatContent = (text: String, type: ChatbotCell, redirectTo: String?, time: String?, step:OnboardingStep)

// MARK: - Onboarding view-model Delegate
protocol OnboardingChatbotDelegate: AnyObject {
    
    func onSetupSteps(arrContent: [chatContent], arrOptions: [chatContent])
    func showError(message: String)
}

// MARK: - OnboardingChatbotViewModel
class OnboardingChatbotViewModel {
    
    var currentStep: OnboardingStep = .notFound
    var onBoardingList: Onboarding?
    var step: String?
    var data: Dictionary<String, Any>?
    weak var delegate: OnboardingChatbotDelegate?
    
    func getOnboardingStatus(completion: @escaping ()->()) {
        
        let token: String? = UserDefaults.onboardToken ?? nil
        SessionManager.default.requestModel(request: Router.onboardingStatus(token: token).urlRequest()) { (response: Onboarding?, error: GlowError?) in
            DispatchQueue.main.async {
                if error != nil {
                    switch error {
                    case .network(let err)?, .parser(let err)?, .custom(let err)? :
                        self.delegate?.showError(message: err)
                    case .none:
                        self.delegate?.showError(message: DEFAULT_API_ERROR())
                    }
                } else {
                    if let object = response {
                        if object.completed ?? false {
                            completion()
                        } else {
                            self.loadNextStep(object: object)
                        }
                    }
                }
            }
        }
    }
    
    func onboardingProgress(completion: @escaping (Bool, String?, Onboarding?) -> ()) {
        
//        guard let step = step else {
//            return
//        }
        guard let data = data else {
            return
        }
        let step = self.currentStep.rawValue
        print("Step is--------", step)
        let token: String? = UserDefaults.onboardToken ?? nil
        SessionManager.default.requestModel(request: Router.onboardingProgress(token: token, step: step, data: data).urlRequest()) { (response: Onboarding?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err, nil)
                case .none:
                    completion(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
                self.onBoardingList = response
                completion(true, nil, response)
            }
        }
    }
    
    func loadNextStep(object: Onboarding) {
        
        var messages = [chatContent]()
        var options = [chatContent]()
        
        if let objStep = object.step {
            if let step = objStep.step {
                self.currentStep = OnboardingStep(rawValue: step) ?? .notFound
            }
            if let arrMessage = objStep.messages {
                messages = arrMessage.map { object in
                    let cellType = ChatbotCell(rawValue: object.type ?? "") ?? .none
                   // return (object.text ?? "", cellType, nil, Date().toString(format: "h:mm a"))
                    return (object.text ?? "", cellType, nil, Date().toString(format: "h:mm a"), self.currentStep)
                }
            }
            if let arrOptions = objStep.options {
                options = arrOptions.map { object in
                    let cellType = ChatbotCell(rawValue: object.type ?? "") ?? .none
                        //return (object.text ?? "", cellType, object.redirectTo, Date().toString(format: "h:mm a"))
                    return (object.text ?? "", cellType, object.redirectTo, Date().toString(format: "h:mm a"), self.currentStep)
                }
            }
        }
        self.delegate?.onSetupSteps(arrContent: messages, arrOptions: options)
    }
}

// MARK: - Validation
extension OnboardingChatbotViewModel {
    
    func validateSignUp(email: String, password: String, repeatPassword: String) -> String? {
        if email.trimWhiteSpace.isEmpty {
            return "Please enter email"
        } else if !email.validateEmail() {
            return "Please enter valid email"
        } else if password.trimWhiteSpace.isEmpty {
            return "Please enter password"
        } else if repeatPassword.trimWhiteSpace.isEmpty {
            return "Please enter repeat password"
        } else if password.compare(repeatPassword) != .orderedSame {
            return "Password and repeat password not same."
        } else {
            return nil
        }
    }
    
    func validateSignIn(email: String, password: String) -> String? {
        if email.trimWhiteSpace.isEmpty {
            return "Please enter email"
        } else if !email.validateEmail() {
            return "Please enter valid email"
        } else if password.trimWhiteSpace.isEmpty {
            return "Please enter password"
        } else {
            return nil
        }
    }
    
    func validateForgotPassword(email: String) -> String? {
        if email.trimWhiteSpace.isEmpty {
            return "Please enter email"
        } else if !email.validateEmail() {
            return "Please enter valid email"
        } else {
            return nil
        }
    }
    
    func validatePhoneNo(phoneNo: String) -> String? {
        if phoneNo.trimWhiteSpace.isEmpty {
            return "Please enter phone no"
        } else if !phoneNo.isValidPhone() {
            return "Please enter valid phone number"
        } else {
            return nil
        }
    }
}
