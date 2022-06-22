//
//  ResponseParser.swift
//  Skylor
//
//  Created by Harsha on 7/6/19.
//  Copyright © 2019 Skylor Lane. All rights reserved.
//

import Foundation
class APIResponse<T:Codable>: Codable {
    var message:T?
    var status: Int?
    var token: String?
    var data:T?
    var error: String?
}


class APIResponseT<T:Codable>: Codable {
    var statusCode:Int?
    var message:String?
    var data:T?
    var error: String?
}

enum APIResult<T> {
    case success(T)
    case error(APIError)
}

class APIStatusResponse <T:Codable>: Codable {
    var success: APIResponse<T>?
    var error: APIErrorResponse?
}


class APIErrorResponse: Codable {
    var status: Int?
    var message: [String]?
    //var errorMessages: [String]?
    
}
