//
//  FirebaseManager.swift
//  Month5HWs
//
//  Created by Jarae on 3/6/23.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    enum FirestoreCollections: String {
        case news, statistics, games, products
    }
    
    static let shared = FirestoreManager()
    private let db = Firestore.firestore()
    
    private init() { }
    
    func saveTo(collection: FirestoreCollections, document: String, data: [String : Any]) {
        db.collection(
            collection.rawValue
        ).addDocument(
            data: data
        )
    }
    
    func readData(collection: FirestoreCollections, completion: @escaping ([String: Any]) -> Void) {
        db.collection(collection.rawValue).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    completion(document.data())
                }
            }
        }
    }
}
