//
//  AuthError.swift
//  Nectar
//
//  Created by tanmaydeep on 06/02/26.
//

import FirebaseAuth

enum AuthError: LocalizedError {
    case invalidEmail
    case weakPassword
    case wrongPassword
    case emailAlreadyInUse
    case userNotFound
    case unknown

    init(error: Error) {
        let nsError = error as NSError

        if let authErrorCode = AuthErrorCode(_bridgedNSError: nsError) {
            switch authErrorCode.code {
            case .invalidEmail:
                self = .invalidEmail
            case .weakPassword:
                self = .weakPassword
            case .wrongPassword:
                self = .wrongPassword
            case .userNotFound:
                self = .userNotFound
            case .emailAlreadyInUse:
                self = .emailAlreadyInUse
            default:
                self = .unknown
            }
        } else {
            self = .unknown
        }
    }

    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Please enter a valid email address."
        case .weakPassword:
            return "Password must be at least 6 characters."
        case .wrongPassword:
            return "Incorrect password. Please try again."
        case .userNotFound:
            return "No account found with this email."
        case .emailAlreadyInUse:
            return "This email is already registered."
        case .unknown:
            return "Something went wrong. Please try again."
        }
    }
}
