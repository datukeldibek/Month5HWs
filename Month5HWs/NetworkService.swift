//
//  NetworkService.swift
//  Month5HWs
//
//  Created by Jarae on 17/5/23.
//

import Foundation

class NetworkService {
    private let baseURL = URL(string: "https://dummyjson.com/products")!
    
    func requestProducts() async throws -> Products {
        let request = URLRequest(url: baseURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try self.decode(data: data)
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
