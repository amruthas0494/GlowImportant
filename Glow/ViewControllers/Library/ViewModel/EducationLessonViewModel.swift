//
//  EducationLessonViewModel.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 03/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

import Foundation

class EducationLessonViewModel: NSObject {
    
    var tab: String?
    var lessonId: String?
    var categoryId: String?
    var lessonListForCategory: EducationLessonList?
    var lessonsSections = [EducationLessonList]()
    var educationLessons = [EducationLesson]()
    
    func getEducationLessonsList(complition:
                                 @escaping (Bool, String?) -> ()) {
        SessionManager.default.requestModel(request: Router.educationLessons.urlRequest()) { (response: [EducationLessonList]?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                self.lessonsSections.removeAll()
                self.lessonsSections = response ?? [EducationLessonList]()
            }
            complition(true, nil)
        }
    }
    
    func getEducationLessonListForCategory(complition:
                                           @escaping (Bool, String?) -> ()) {
        
        var urlRequestIs: URLRequest?
        if let categoryId = categoryId {
            urlRequestIs = Router.lessonsByCategory(categoryId: categoryId).urlRequest()
        } else if let tab = tab {
            urlRequestIs = Router.lessonsByTab(tab: tab).urlRequest()
        }
        guard let urlRequest = urlRequestIs else {
            return
        }
        SessionManager.default.requestModel(request: urlRequestIs!) {
            (response: EducationLessonList?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                self.lessonListForCategory = response
            }
            complition(true, nil)
        }
    }
    
    
    func addLessonToFavourites(complition: @escaping (Bool, String?) -> ()) {
        
        guard let lessonId = lessonId else {
            return
        }
        SessionManager.default.requestModel(request: Router.addFavourite(lessonId: lessonId).urlRequest()) { (response: EducationLessonList?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                //self.lessonListForCategory = response
            }
            complition(true, nil)
        }
    }
    
    func removeLessonFromFavourite(complition: @escaping (Bool, String?) -> ()) {
        
        guard let lessonId = lessonId else {
            return
        }
        SessionManager.default.requestModel(request: Router.removeFavourites(lessonId: lessonId).urlRequest()) { (response: Bool?, error: GlowError?) in
            
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                print(response ?? false)
            }
            complition(true, nil)
        }
    }
    
    func getEducationLessonByLessonId(complition:
                                      @escaping (Bool, String?, EducationLesson?) -> ()) {
        guard let lessonId = lessonId else {
            complition(false, nil, nil)
            return
        }
        SessionManager.default.requestModel(request: Router.lessonDetail(lessonId: lessonId).urlRequest()) {
            (response: EducationLesson?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err, nil)
                case .none:
                    complition(false, DEFAULT_API_ERROR(), nil)
                }
            }
            complition(true, nil, response)
        }
    }
}
