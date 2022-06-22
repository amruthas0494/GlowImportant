//
//  TouchIDAuthentication.swift
//  Glow
//
//  Created by apple on 29/12/21.
//  Copyright © 2021 CC. All rights reserved.
//

import Foundation
import LocalAuthentication

class BiometricIDAuth {
    
    let context = LAContext()
    var loginReason = "Logging in with Touch ID"
    
    func biometricType() -> LABiometryType {
        let isLockEnabled = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        if isLockEnabled {
            return context.biometryType
        } else {
            return LABiometryType.none
        }
    }
    
    func canEvaluatePolicy() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    func canEvaluatePolicy1() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }
    
    func evaluateError(error: NSError?) -> String {
        switch error {
        case LAError.authenticationFailed?:
            return "There was a problem verifying your identity."
        case LAError.userCancel?:
            return "You pressed cancel."
        case LAError.userFallback?:
            return "You pressed password."
        case LAError.biometryNotAvailable?:
            return "Face ID/Touch ID is not available."
        case LAError.biometryNotEnrolled?:
            return "Face ID/Touch ID is not set up."
        case LAError.biometryLockout?:
            return "Face ID/Touch ID is locked."
        default:
            return "Face ID/Touch ID may not be configured"
        }
    }
    
    func authenticateUser(completion: @escaping (String?) -> Void) {
        
        var error: NSError?
        let biometric = self.biometricType()
        
        switch biometric {
        case .none:
            break
        case .touchID, .faceID:
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "Please authenticate yourself to unlock."
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {[weak self] success, authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            completion(nil)
                        } else {
                            let error = self?.evaluateError(error: error)
                            completion(error)
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion("no biometrics")
                }
            }
        @unknown default:
            break
        }
    }
}
