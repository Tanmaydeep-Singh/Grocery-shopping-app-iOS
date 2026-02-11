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

            print("RegisterUserService: called")

            do {
                if let encodedData = try? JSONEncoder().encode(body),
                       let jsonString = String(data: encodedData, encoding: .utf8) {
                        print("DEBUG: Sending JSON Body -> \(jsonString)")
                    }
                
                let response: RegisterUserResponse =
                    try await networkClient.request(
                        endpoint: RegisterationEndpoint.register(body)
                    )

                print("RegisterUserService: success")
                return response

            } catch {
                print("RegisterUserService ERROR:", error)
                print("TYPE:", type(of: error))
                throw error
            }
    }
}
