//
//  NetworkMaager.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

final class NetworkClient {

    static let shared = NetworkClient()
    private init() {}

    func request<T: Decodable>(
        url: URL,
        method: String,
        body: Data? = nil
    ) async throws -> T {

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.requestFailed
        }

        guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.decodingFailed
        }

        return decoded
    }
}
