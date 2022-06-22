//
//  TouchIDAuthentication.swift
//  Glow
//
//  Created by apple on 29/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import Foundation

import LocalAuthentication
enum BiometricType {
    case none
    case touchID
    case faceID
}
class BiometricIDAuth {
    
    let context = LAContext()
    var loginReason = "Logging in with Touch ID"
    
    func biometricType() -> BiometricType {
        let _ = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        switch context.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        }
    }
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }
    func canEvaluatePolicy1() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }
    func authenticateUser(completion: @escaping (String?) -> Void) {
        
        switch context.biometryType {
        case .touchID:
            guard canEvaluatePolicy1() else {
                completion("Touch ID not available")
                return
            }
            context.localizedFallbackTitle = "Please use your Passcode"
            
            var authorizationError: NSError?
            let reason = "Authentication required to access the secure data"
            
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
                
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                    
                    if success {
                        DispatchQueue.main.async() {
                            // User authenticated successfully, take appropriate action
                            print("correct")
                            completion(nil)
                        }
                        
                    } else {
                        // Failed to authenticate
                        let message: String
                        guard let error = evaluateError
                            else {
                                
                                
                                switch evaluateError {
                                case LAError.authenticationFailed?:
                                    message = "There was a problem verifying your identity."
                                case LAError.userCancel?:
                                    message = "You pressed cancel."
                                case LAError.userFallback?:
                                    message = "You pressed password."
                                case LAError.biometryNotAvailable?:
                                    message = "Face ID/Touch ID is not available."
                                case LAError.biometryNotEnrolled?:
                                    message = "Face ID/Touch ID is not set up."
                                case LAError.biometryLockout?:
                                    message = "Face ID/Touch ID is locked."
                                default:
                                    message = "Face ID/Touch ID may not be configured"
                                }
                                
                                completion(message)
                                return
                        }
                        print(error)
                        
                    }
                }
            }
            
            
        case .faceID:
            guard canEvaluatePolicy() else {
                completion("Face ID not available")
                return
            }
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: loginReason) { (success, evaluateError) in
                if success {
                    DispatchQueue.main.async {
                        // User authenticated successfully, take appropriate action
                        print("correct")
                        completion(nil)
                    }
                } else {
                    let message: String
                    
                    switch evaluateError {
                    case LAError.authenticationFailed?:
                        message = "There was a problem verifying your identity."
                    case LAError.userCancel?:
                        message = "You pressed cancel."
                    case LAError.userFallback?:
                        message = "You pressed password."
                    case LAError.biometryNotAvailable?:
                        message = "Face ID/Touch ID is not available."
                    case LAError.biometryNotEnrolled?:
                        message = "Face ID/Touch ID is not set up."
                    case LAError.biometryLockout?:
                        message = "Face ID/Touch ID is locked."
                    default:
                        message = "Face ID/Touch ID may not be configured"
                    }
                    
                    completion(message)
                    
                }
            }
        case .none:
            print("none")
            
            
        default:
            print("error")
        }
        
    }
    
    
    
    
}
