//
//  Router.swift
//  Contacts
//
//  Created by Harsha on 30/07/19.
//  Copyright © 2019 Skylor Lane. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    case put
    case delete
    case patch
    var type: String { return self.rawValue.uppercased() }
    var method: String {
        switch self {
        case .get: return Constant.HttpMethod.get
        case .put: return Constant.HttpMethod.put
        case .post: return Constant.HttpMethod.post
        case .patch: return Constant.HttpMethod.patch
        case .delete: return Constant.HttpMethod.delete
        }
    }

}

enum ParametersEncoding {
    case json
    case url
    case formData

}
enum socketMessageType: String, Codable{
    case video
    case image
    case audio
    case text
    var type: String { return self.rawValue }
}
enum PostType: String{
    case video
    case image
    case podcast
    case challenge
    var type: String { return self.rawValue }
}
enum URLType{
    case Development
    case Local
}
public typealias Parameters = [String: Any]

enum Task {
    case request
    case requestParameters(Parameters)
    case requestParametersWithFile(Parameters,fileKey: String,coverImageFileKey:String?,imageDataKey:Data, coverImageDataKey: Data?, boundary:String,fileName: String, coverImagefileName: String?, postType: PostType, thumbImageFileKey: String,thumbnailImageDataKey: Data?, thumbnailFileName: String)
    case requestWithPresignedURL(fileName: String, imageData: String)
}

public typealias Headers = [String: String]

protocol RequestProtocol {
    var path: String { get }
    var task: Task { get }
    var method: HTTPMethod { get }
    var headers: Headers? { get }
    var parametersEncoding: ParametersEncoding { get }
}
