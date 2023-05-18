//
//  UserDefaultStorage.swift
//  Month5HWs
//
//  Created by Jarae on 18/5/23.
//

import Foundation

final class UserdefaultStorage {
    
    enum Keys: String {
        case productName
    }
    
    static let shared = UserdefaultStorage()
    
    private init() { }
    
    func save<T: Any>(_ item: T, forKey key: Keys) {
        UserDefaults.standard.set(item, forKey: key.rawValue)
    }
    
    func remove(forKey key: Keys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    func getString(forKey key: Keys) -> String? {
        UserDefaults.standard.string(forKey: key.rawValue)
    }
}
