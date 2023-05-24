//
//  NetworkService.swift
//  Month5HWs
//
//  Created by Jarae on 17/5/23.
//

import Foundation

class NetworkService {
    func requestProducts(completion: @escaping (Result<Products, Error>) -> Void) {
        let request = URLRequest(url: Constants.API.baseURL)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }
            completion(.success(try! self.decode(data: data)))
        }
        .resume()
    }
    
    func requestProducts() async throws -> Products {
        let request = URLRequest(url: Constants.API.baseURL)
        let (data, _) = try await URLSession.shared.data(for: request)
        return try self.decode(data: data)
    }
    
    private func decode<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
