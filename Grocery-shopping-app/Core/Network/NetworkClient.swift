//
//  NetworkMaager.swift
//  Grocery-shopping-app
//
//  Created by tanmaydeep on 04/02/26.
//

// NetworkClient.swift

import Foundation

final class NetworkClient {

    // Singleton instance of Network Client.
    static let shared = NetworkClient()
    private init() {}

    func request<T: Decodable>(
        endpoint: Endpoint, // Acceping Endpoint obj
        body: Encodable? = nil
    ) async throws -> T {

        // URL construction for api call.
        let url = NetworkConfig.baseURL.appendingPathComponent(endpoint.path)

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body {
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
