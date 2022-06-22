//
//  SessionManager.swift
//  HAICA
//
//  Created by Nidhishree  on 06/05/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
typealias JSON = [String: AnyObject]



class SessionManager {
    
    var defaultSession: URLSession {
        return URLSession(configuration: defaultSessionConfiguration,delegate: SSLPinningManger(), delegateQueue: nil)
    }
    var timoutInterval: Int = 60
    
    static var `default`: SessionManager {
        struct Shared {
            static let instnce = SessionManager()
        }
        return Shared.instnce
    }
    
    private init() { }
    
    var defaultSessionConfiguration : URLSessionConfiguration {
        get {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = Constant.NetworkConstants.requestTimeout
            configuration.timeoutIntervalForResource = Constant.NetworkConstants.resourseTimeout
            configuration.requestCachePolicy = .useProtocolCachePolicy
            configuration.waitsForConnectivity = true
            configuration.isDiscretionary = true
            configuration.httpCookieAcceptPolicy = .always
            return configuration
        }
    }
}

extension SessionManager {
    //for dict response
    func requestModel<T: Codable>(request: URLRequest, _ completiobHandler: @escaping ((_ result: T?, _ error: GlowError?) -> Void)) {
        if !(Reachability()?.isConnectedToNetwork() ?? false) {
            print("no network")
            completiobHandler(nil, GlowError.network(string: "No network"))
        }
        self.dataTask(withRequest: request) { (response: T?, erro: String?) in
            if erro != nil {
                completiobHandler(nil, GlowError.custom(string: erro ?? DEFAULT_API_ERROR()))
            } else {
                completiobHandler(response, nil)
            }
        }
    }
    
}

extension SessionManager {
    //for dict response
    func dataTask<T: Codable>(withRequest request: URLRequest, completion: ((_ response: T?, _ error: String?) -> Void)? = nil) {
        
        self.defaultSession.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion?(nil, error?.localizedDescription ?? "")
            }
            if let urlResponse = response as? HTTPURLResponse, let responseData = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if (200..<400).contains(urlResponse.statusCode) {
                    do {
                        self.printJSON(withData: data)
                        let temp = try decoder.decode(APIResponseT<T>.self, from: responseData)
                        completion?(temp.data, nil)
                    } catch let error {
                        print(error.localizedDescription)
//                        let temp = try decoder.decode(APIResponseT<T>.self, from: responseData)
//                        completion?(nil, temp.message ?? error.localizedDescription)
                        do {
                            self.printJSON(withData: data)
                            let temp = try decoder.decode(APIResponseT<T>.self, from: responseData)
                            guard let status = temp.statusCode else {
                                completion?(nil, temp.message ?? DEFAULT_API_ERROR())
                                return
                            }
                            if (200..<299).contains(status){
                                completion?(nil, nil)
                            } else {
                                completion?(nil, temp.message ?? DEFAULT_API_ERROR())
                            }
                        } catch {
                            completion?(nil, error.localizedDescription)

                        }
                    }
                } else {
                    do {
                        self.printJSON(withData: data)
                        
                        let temp = try decoder.decode(APIErrorResponse.self, from: responseData)
                        completion?(nil, temp.message?[0] ?? DEFAULT_API_ERROR())//BSError.custom(string: temp.message ?? DEFAULT_API_ERROR()))
                    } catch {
                        completion?(nil, error.localizedDescription)
                    }
                }
            }}.resume()
    }
    
    func cancelAllRequest(for path: String) {
        guard let url = URL(string: path) else { return }
        self.defaultSession.getAllTasks { tasks in
            tasks.forEach {
                if $0.originalRequest?.url?.lastPathComponent == url.lastPathComponent {
                    $0.cancel()
                }
            }
        }
    }
    
    func printJSON(withData data: Data?) {
        if let responseData = data {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String:Any]
                print(jsonData ?? "Empty")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    func sendJSON(withData data: Data?) -> [String:Any]? {
        if let responseData = data {
            do {
                let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String:Any]
//                print(jsonData ?? "Empty")
                return jsonData
            } catch {
                print("Error: \(error.localizedDescription)")
                return nil
            }
        }
        return nil
    }
}


extension SessionManager {
    
    func downloadImageData(imageUrl url: URL, withCompletion completionHandler: ((_ success: Bool, _ data: Data?) -> Void)? = nil) {
        self.defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completionHandler?(false, nil)
                return
            }
            
            if let urlResponse = response as? HTTPURLResponse {
                if (200..<300).contains(urlResponse.statusCode) {
                    completionHandler?(true, data)
                    return
                }
            }
            }.resume()
    }
}
extension String {
    public func getDomain() -> String? {
        guard let url = URL(string: self) else { return nil }
        return url.host
    }
}
enum GlowError: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
}
func DEFAULT_API_ERROR() -> String {
    return "Something went wrong"
}
//MARK:- LoggingPrint
func loggingPrint<T>( _ object: @autoclosure () -> T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    //#if DEBUG
    let value = object()
    
    print(value)
    //#endif
}
