//
//  ViewModel.swift
//  Month5HWs
//
//  Created by Jarae on 18/5/23.
//
import Foundation

class ProductsViewModel {
    
    let networkService: NetworkService
    
    init() {
        self.networkService = NetworkService()
    }
    
    func fetchProducts() async throws -> [Product] {
        try await networkService.requestProducts().products
    }
    
    func requestProducts(completion: @escaping (Result<Products, Error>) -> Void) {
        networkService.requestProducts(completion: completion)
    }
}
