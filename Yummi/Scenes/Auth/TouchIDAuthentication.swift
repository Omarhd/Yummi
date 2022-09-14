//
//  TouchIDAuthentication.swift
//  Yummi
//
//  Created by Omar Abdulrahman on 05/09/2022.
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
    @unknown default:
        return .none
    }
  }

  func canEvaluatePolicy() -> Bool {
    return context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
  }

  func authenticateUser(completion: @escaping (String?) -> Void) {
    guard canEvaluatePolicy() else {
      completion("Touch ID not available")
      return
    }
    
    context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: loginReason) { (success, evaluateError) in
      if success {
        DispatchQueue.main.async {
          // User authenticated successfully, take appropriate action
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
        completion(message)                            }
    }
  }
}
