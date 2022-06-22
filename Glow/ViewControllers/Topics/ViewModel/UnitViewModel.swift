//
//  UnitViewModel.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 03/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

class UnitViewModel: NSObject {

    var lessonId: String?
    var type: String?
    var educationLessonUnitId: String?
    var UnitId:String?
    
    func getLessonUnit(complition: @escaping (Bool, String?, [Unit]?) -> ()) {
        
        guard let lessonId = lessonId else {
            complition(false, nil, nil)
            return
        }
        SessionManager.default.requestModel(request: Router.lessonUnits(lessonId: lessonId).urlRequest()) { (response: [Unit]?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err, nil)
                case .none:
                    complition(false, DEFAULT_API_ERROR(), nil)
                }
            } else {
                print(error.debugDescription )
            }
            if let units = response {
                for eachunit in units {
                    self.UnitId = eachunit.id
                }
            }
            complition(true, nil, response)
        }
    }
    
    func webunitStartEnd(completion: @escaping (Bool, String?) -> ()) {
        guard let lessonId = lessonId,
                let type = self.type,
                let educationLessonUnitId = self.educationLessonUnitId else {
            completion(false, nil)
            return
        }
        SessionManager.default.requestModel(request: Router.unitStartEnd(lessonId: lessonId, type: type, educationLessonUnitId: educationLessonUnitId).urlRequest()) { (response: Unit?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    completion(false, err)
                case .none:
                    completion(false, DEFAULT_API_ERROR())
                }
            } else {
                print(error.debugDescription )
                completion(true, nil)
            }
        }
    }
}
