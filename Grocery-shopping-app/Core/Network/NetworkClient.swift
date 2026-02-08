//
//  NetworkMaager.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

// NetworkClient.swift

import Foundation

final class NetworkClient {

    //Singleton
    static let shared = NetworkClient()
    private init() {}

    func request<T: Decodable>(
        endpoint: Endpoint
    ) async throws -> T {

        var components = URLComponents(
            url: NetworkConfig.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )

        components?.queryItems = endpoint.queryItems

        // Complete URL construction.
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body = endpoint.body {
            request.httpBody = try JSONEncoder().encode(body)
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
