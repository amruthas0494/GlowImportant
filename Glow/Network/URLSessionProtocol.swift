//
//  URLSessionProtocol.swift
//  Contacts
//
//  Created by Harsha on 30/07/19.
//  Copyright © 2019 Skylor Lane. All rights reserved.
//

import Foundation

protocol URLSessionProtocol: AnyObject {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}
