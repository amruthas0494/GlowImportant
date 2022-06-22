//
//  APIRouter.swift
//  HAICA
//
//  Created by Nidhishree  on 06/05/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

enum Router {
    
    case login(userName:String, password:String, fcmToken: String)
    case logOut(fcmToken: String)
    case forgotPassword(email: String)
    case educationLessons
    case lessonUnits(lessonId: String)
    case addReview(lessonId: String, rating: Int, review: String, suggestion: String)
    case addFavourite(lessonId: String)
    case removeFavourites(lessonId: String)
    case addReflectionJournal(lessonId: String, unitId: String, value: String, numberValue: Int)
    case addComments(lessonId: String, comments: String)
    case getComments(lessonId: String)
    case lessonsByCategory(categoryId: String)
    case lessonsByTab(tab: String)
    case favourites(userId: String)
   // case
    case getAllReflectionJournal(userId: String)
    case getReflectionJournal(lessonId: String, educationLessonUnitId: String)
    case getRecentSearches
    case deleteRecentSearch(searchId: String)
    case createRecentSearch(keyword: String)
    case search(keyword: String)
    case lessonDetail(lessonId: String)
    case users(userId: String, firstName: String, lastName: String, gender: String, dob: String)
    case onboardingStatus(token: String?)
    case onboardingProgress(token: String?, step: String, data: Dictionary<String, Any>)
    case resendOTP(phoneNo: String)
    case unitStartEnd(lessonId: String, type: String, educationLessonUnitId: String)
    case previousStep(botId: String)
    case currentStep(botId: String)
    case previewNextStep(botId:String, botStepId: String, stepType: String, response: [String: Any])
    case getStepById(stepId:String)
    case submitBotResponse(botId: String, botStepId: String, stepType: String, response: [String: Any], timeTaken: Int)
    case bots(page: Int, size: Int, status: String = "active")
    case bookmarksList
    case moduleSummary(lessonId: String)
    case getFAQTopics
    case getInAppNotifications(userId: String, page:Int, size:Int)
    case putReadNotifications(notificationId: String, isRead: Bool)
}

extension Router {
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login,.logOut, .forgotPassword, .addReview,.previewNextStep, .addFavourite, .addReflectionJournal, .addComments, .createRecentSearch, .onboardingProgress, .resendOTP, .unitStartEnd, .submitBotResponse:
            return .post
        case .educationLessons, .lessonUnits, .getComments, .lessonsByCategory(categoryId:), .lessonsByTab(tab:), .favourites(userId:), .getAllReflectionJournal(userId:), .getRecentSearches, .search(keyword:), .lessonDetail(lessonId:), .onboardingStatus, .previousStep(botId:), .currentStep(botId:), .getReflectionJournal, .getStepById(stepId:),.bots, .bookmarksList, .getFAQTopics, .getInAppNotifications(userId:), .moduleSummary(lessonId:) :
            return .get
        case .removeFavourites, .deleteRecentSearch(searchId:):
            return .delete
        case .users, .putReadNotifications:
            return .put
    
       
        }
    }
    
    var headers: [String: String] {
        switch self {
        default:
            var headers = [String: String]()
            headers["Content-Type"] = "application/json"
            headers["Content-Length"] = "0"
            if let token = KeychainWrapper.standard.string(forKey: Constant.loginConstants.authToken) {
                headers["Authorization"] = "Bearer " + token
            }
            return headers
        }
    }
    
    var baseUrl: String? {
        switch self {
        default:
            //dev
            //return "http://ec2-50-17-221-224.compute-1.amazonaws.com:4000"
            //client
            //         return "http://ec2-54-221-22-252.compute-1.amazonaws.com:4000"
            //staging
            return "http://35.208.218.117"
        }
    }
    
    var body: Data? {
        var dictionary: [String: Any]?
        switch self {
        case .login(let userName, let password, let fcmToken):
//            let fcmToken: String = UserDefaults.standard.string(forKey: Constant.loginConstants.fcmToken) ?? ""
//            dictionary = ["email":"\(userName)","password": "\(password)", "role":"participant","fcmToken":fcmToken]
            dictionary = ["email":"\(userName)","password": "\(password)", "fcmToken": "\(fcmToken)"]
            //            loggingPrint("PARAMS:=\(String(describing: dictionary))")
           
        case .logOut(let fcmToken):
            dictionary = ["fcmToken": "\(fcmToken)"]
        case .forgotPassword(let email):
            dictionary = ["email":"\(email)"]
        case .lessonUnits(lessonId:), .getComments(lessonId:):
            dictionary = nil
       
        case .addReview(_, let rating, let review, let suggestion):
            dictionary = ["rating":"\(rating)",
                          "review": "\(review)",
                          "suggestion": "\(suggestion)"]
        case .addComments(_, let comments):
            dictionary = ["comment": comments]
        case .addReflectionJournal(_, let unitId, let value, let numberValue):
            dictionary = ["value": value,
                          "educationLessonUnitId": unitId,
                          "numberValue": numberValue]
        case .createRecentSearch(let keyword):
            dictionary = ["keyword": keyword]
        case .users(_, let firstName, let lastName, let gender, let dob):
            dictionary = ["firstName": firstName,
                          "lastName": lastName]
        case.putReadNotifications(_, let isRead):
            dictionary = ["isRead": isRead]

        case .onboardingProgress(_, let step, let data):
            dictionary = ["step": step,
                          "data": data]
        case .resendOTP(let phoneNo):
            dictionary = ["phoneNumber": phoneNo]
        case .unitStartEnd(_, let type, let educationLessonUnitId):
            dictionary = ["type": type,
                          "educationLessonUnitId": educationLessonUnitId]
        case .submitBotResponse(_, let botStepId, let stepType, let response, let timeTaken):
            dictionary = ["botStepId": botStepId,
                          "stepType": stepType,
                          "response": response,
                          "timeTaken": timeTaken]
        case .previewNextStep(_, let botStepId, let stepType, let response):
            dictionary = ["botStepId": botStepId,
                          "stepType": stepType,
                          "response": response]
        default : break
        }
        return dictionary?.json?.data(using: .utf8)
    }
    
    var parameters: [String: Any] {
        var parameters = [String: Any]()
        switch self {
        case .login, .logOut, .previewNextStep, .forgotPassword(email:), .educationLessons, .lessonUnits(lessonId:), .addReview, .addFavourite, .removeFavourites, .addReflectionJournal, .addComments, .getComments(lessonId:), .favourites(userId:), .getRecentSearches, .deleteRecentSearch(searchId:), .createRecentSearch(keyword:), .lessonDetail(lessonId:), .users, .resendOTP, .unitStartEnd, .previousStep(botId:), .currentStep(botId:), .getStepById(stepId:),.submitBotResponse, .bookmarksList, .getFAQTopics, .moduleSummary(lessonId:), .putReadNotifications, .getAllReflectionJournal(userId:):
            break
        case .lessonsByCategory(let categoryId):
            parameters = ["categoryId": categoryId]
        case .lessonsByTab(let tab):
            parameters = ["tab": tab]
        case .search(let keyword):
            parameters = ["q": keyword]
        case .onboardingProgress(let token,_ ,_):
            if let token = token {
                parameters = ["token": token]
            }
        case .onboardingStatus(let token):
            if let token = token {
                parameters = ["token": token]
            }
        case .bots(let page, let size, let status):
            parameters = ["page": page,
                          "size": size,
                          "status": status]
        case .getInAppNotifications(let userId, let page, let size):
            parameters = ["userId": userId,
                          "page": page,
                          "size": size]
        case .getReflectionJournal(_, let id):
            parameters = ["educationLessonUnitId": id]
       
                }
        return parameters
    }
}
extension Router {
    
    func urlRequest() -> URLRequest {
        guard let baseUrl = self.baseUrl else { fatalError("Invalid Base URL") }
        var urlComponents = URLComponents(string: baseUrl)
        urlComponents?.path = URLBuilder.endPointUrl(ofAPI: self)
        urlComponents?.queryItems = Router.queryItems(parameters)
        
        guard let url = urlComponents?.url else {
            preconditionFailure("Failed to construct URL")
        }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: Constant.NetworkConstants.requestTimeout)
        
        print("Request url === \(url)")
        print("Method === \(httpMethod.method)")
        if let data = body {
        do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                print(json)
            } catch {
                print("Something went wrong")
            }
        }
        request.httpMethod = httpMethod.method
        for (key, value) in headers { request.setValue(value, forHTTPHeaderField: key) }
        request.httpBody = body
        return request
    }
}

extension Router {
    static func queryItems(_ parameters : [String : Any]) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            queryItems.append(queryItem)
        }
        return queryItems
    }
}

extension Dictionary {
    var json:String? {
        var jsonString: String?
        do {
            if let theJSONData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
                jsonString = String(data: theJSONData, encoding: .utf8)
            }
        }
        return jsonString
    }
}
