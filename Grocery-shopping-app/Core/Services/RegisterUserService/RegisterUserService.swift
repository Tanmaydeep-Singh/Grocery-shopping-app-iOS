//
//  RegisterUserService.swift
//  Nectar
//
//  Created by tanmaydeep on 09/02/26.
//

import Foundation

final class RegisterUserService : RegisterUserServiceProtocol {
    
    private let networkClient: NetworkClient

    // Initializing Network Client
    init(networkClient: NetworkClient = .shared) {
        self.networkClient = networkClient
    }
    
    func registerUser(
        body: RegisterUserRequest
    ) async throws -> RegisterUserResponse {
        try await networkClient.request(
            endpoint: RegisterationEndpoint.register(
                body
            ))
    }
}
