//
//  RegisterUserProtocol.swift
//  Nectar
//
//  Created by tanmaydeep on 09/02/26.
//

import Foundation

protocol RegisterUserServiceProtocol {
    func registerUser(
        body: RegisterUserRequest
    ) async throws -> RegisterUserResponse
}
