//
//  getNotifications.swift
//  Glow
//
//  Created by Cognitiveclouds on 05/06/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

class NotificationViewModel: NSObject {
    
    var userId: String?
    var educationLessonId:String?
    
    //    //Current step
    //    var stepId: String?
    //    var stepType: BotOptionType = .typing
    var Notification: NotificationData?
    var notificationlist:NotificationList?
    var readNotifications: ReadNotifications?
    //    var currentStep: ChatbotStep?
    //
    var page: Int = 1
    var size: Int = 20
    
    func getNotification(completion: @escaping (Bool, String?, NotificationData?) -> ()) {
        
        guard let userId = Glow.sharedInstance.userId else {
            completion(false, "No Notifications.", nil)
            return
        }
        SessionManager.default.requestModel(request: Router.getInAppNotifications(userId: userId, page: page, size: size).urlRequest()) {(result: NotificationData?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err, nil)
                case .none:
                    completion(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
                self.Notification = result
                // self.educationLessonId = result?.notifications
                let numbers =  (self.Notification?.count)! - (self.Notification?.unreadCount)!
                
                print(numbers)
                completion(true, nil, result)
               
            }
        }
        
    }
    
    func putReadNotifications(notificationId: String, isRead:Bool, complition: @escaping (Bool, String?) -> ()) {

        
        SessionManager.default.requestModel(request: Router.putReadNotifications(notificationId: notificationId, isRead: isRead).urlRequest()) { (response: ReadNotifications?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                self.readNotifications = response
                complition(true, nil)
            }
        }
    }
    
    
}
