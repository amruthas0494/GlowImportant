//
//  ReflectionJournalViewModel.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 04/01/22.
//  Copyright © 2022 CC. All rights reserved.
//

class ReflectionJournalViewModel: NSObject {
    
    var lessonId: String?
    var value: String?
    var numberValue: Int?
    var unitId: String?
    var arrUnit = [Unit]()
    var arrReflection = [ReflectionJournal]()
    var arrayJournals : ReflectionById?
    
    func addReflectionJournal(complition: @escaping (Bool, String?) -> ()) {
        
        guard let lessonId = lessonId, let unitId = unitId, let value = value, let numberValue = numberValue else {
            complition(false, nil)
            return
        }
        SessionManager.default.requestModel(request: Router.addReflectionJournal(lessonId: lessonId, unitId: unitId, value: value, numberValue: numberValue).urlRequest()) { (response: ReflectionJournal?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let err)?, .parser(let err)?, .custom(let err)? :
                    complition(false, err)
                case .none:
                    complition(false, DEFAULT_API_ERROR())
                }
            } else {
                print(response)
                complition(true, nil)
            }
        }
    }
    func getReflectionJournal(completion: @escaping (Bool, String?, [ReflectionJournal]?) -> ()) {
      
        print(self.unitId)
        guard let userId = Glow.sharedInstance.userId else {
            completion(false, nil, nil)
            return
        }
      
        SessionManager.default.requestModel(request: Router.getAllReflectionJournal(userId: userId).urlRequest()) { (response:[ReflectionJournal]?, error: GlowError?) in
            if error != nil {
                switch error {
                case .network(let error)?, .parser(let error)?, .custom(let error)? :
                    completion(false, error, nil)
                case .none:
                    completion(false, DEFAULT_API_ERROR(), nil)
                }
            }
            self.arrReflection.removeAll()
            self.arrReflection = response ?? []
            completion(true, nil, response)
        }
       
    }
    
    func getReflectionJournalById(completion: @escaping (Bool, String?, ReflectionById? ) -> ()) {
        var uuid = UUID(uuidString: self.unitId ?? "")
        print(self.lessonId)
        guard let lessonId = self.lessonId, let id = self.unitId  else {
            completion(false, nil, nil)
            return
        }
        SessionManager.default.requestModel(request: Router.getReflectionJournal(lessonId: lessonId, educationLessonUnitId: id).urlRequest()) { (response: ReflectionById?, error:GlowError?) in
            if error != nil {
                switch error {
                case .network(let error)?, .parser(let error)?, .custom(let error)? :
                    completion(false, error, nil)
                case .none:
                    completion(false, DEFAULT_API_ERROR(), nil)
                }
            }
            else {
                //self.arrReflection.removeAll()
                self.arrayJournals = response
                print("journal response", self.arrayJournals)
                completion(true, nil, response)
            }
           
        }
        }
       
   
}
