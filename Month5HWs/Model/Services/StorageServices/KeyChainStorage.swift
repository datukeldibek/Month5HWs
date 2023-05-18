//
//  KeyChainStorage.swift
//  Month5HWs
//
//  Created by Jarae on 18/5/23.
//

import Foundation

class KeyChainManager {
    enum Storage: String {
        case favoriteColor
    }
    
    static let shared = KeyChainManager()
    
    private init() { }
        
    func save(_ data: Data, service: String, account: String) {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        if status == errSecDuplicateItem {
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account
            ] as CFDictionary

            let changedAttributes = [kSecValueData: data] as CFDictionary
            SecItemUpdate(query, changedAttributes)
        }
        
        print(status)
    }
    
    func read(with service: String, _ account: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true
        ] as CFDictionary
        
//        var result: AnyObject?
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return (result as? Data)
    }
    
    func delete(with service: String, _ account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary
        
        SecItemDelete(query)
    }
    
    func decode<T: AnyObject>(data: Data) -> T {
        if
        return try JSONEncoder().encode(data)
    }
}
