//
//  CommentViewModel.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 05/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

class CommentViewModel: NSObject {

    var lessonId: String?
    var comment: String?
    var arrComments: [Comment]?
    
    func saveComment(completion: @escaping (Bool, String?) -> ()) {
        
        guard let lessonId = lessonId, let comment = self.comment else {
            return
        }
        
        SessionManager.default.requestModel(request: Router.addComments(lessonId: lessonId, comments: comment).urlRequest()) { (response: Comment?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err)
                case .none:
                    completion(false, DEFAULT_API_ERROR())
                }
            }
            if let objComment = response {
                self.arrComments?.append(objComment)
            }
            completion(true, nil)
        }
    }
    
    
    func getAllComments(completion: @escaping (Bool, String?) -> ()) {
        
        guard let lessonId = lessonId else {
            return
        }

        SessionManager.default.requestModel(request: Router.getComments(lessonId: lessonId).urlRequest()) { (response: CommentData?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err)
                case .none:
                    completion(false, DEFAULT_API_ERROR())
                }
            }
            self.arrComments = response?.rows ?? []
            completion(true, nil)
        }
       
    }
}
