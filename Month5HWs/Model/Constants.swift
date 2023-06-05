//
//  Constants.swift
//  Month5HWs
//
//  Created by Jarae on 18/5/23.
//

import Foundation
enum Constants {
    enum API {
        static let baseURL = URL(string: "https://dummyjson.com/products")!
    }
    
    enum Keychain {
        static let service = "PhoneId"
        static let account = "PhoneSignin"
    }
    
    enum Auth {
        static let verificationID = "vID"
    }
}

