//
//  LessonReviewViewModel.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 04/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

class LessonReviewViewModel: NSObject {
    
    var lessonId: String?
    var rating: Int?
    var review: String?
    var suggestion: String?
    
    func addReview(complition: @escaping (Bool, String?) -> ()) {
        
        guard let lessonId = lessonId, let rating = rating, let review = review, let suggestion = suggestion else {
            complition(false, nil)
            return
        }
        SessionManager.default.requestModel(request: Router.addReview(lessonId: lessonId, rating: rating, review: review, suggestion: suggestion).urlRequest()) { (response: LessonReview?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                complition(true, nil)
            }
        }
    }
    
    func moduleSummaryForLesson(complition: @escaping (Bool, String?, ModuleSummary?) -> ()) {
        
        guard let lessonId = lessonId else {
            complition(false, nil, nil)
            return
        }
        SessionManager.default.requestModel(request: Router.moduleSummary(lessonId: lessonId).urlRequest()) { (response: ModuleSummary?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err, nil)
                case .none:
                    complition(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
                complition(true, nil, response)
            }
        }
    }
}
