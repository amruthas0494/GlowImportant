//
//  ProviderProtocol.swift
//  Contacts
//
//  Created by Harsha on 30/07/19.
//  Copyright © 2019 Skylor Lane. All rights reserved.
//

import Foundation

protocol RequestProviderProtocol {
    func request<T: Codable>(type: T.Type, service: RequestProtocol, completion: @escaping ((NetworkReponse<T>) -> Void))
}

public enum NetworkReponse<T> {
    case success(T)
    case failure(APIError)
}

public enum NetworkError {
    case unknown
    case noJSONData
}
