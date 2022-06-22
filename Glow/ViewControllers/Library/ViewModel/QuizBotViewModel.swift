//
//  QuizBotViewModel.swift
//  Glow
//
//  Created by Cognitiveclouds2021_4 on 08/03/22.
//  Copyright © 2022 CC. All rights reserved.
//

import UIKit

class QuizBotViewModel: NSObject {

    var page: Int = 1
    var size: Int = 30
    var status: String = "active"
    
    func getQuizBotList(complition: @escaping (Bool, String?, BotResponse?) -> ()) {
        
        SessionManager.default.requestModel(request: Router.bots(page: page, size: size, status: status).urlRequest()) { (response: BotResponse?, error: GlowError?) in
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
