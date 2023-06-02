//
//  AuthorizationManager.swift
//  Month5HWs
//
//  Created by Jarae on 3/6/23.
//

import FirebaseAuth
import FirebaseCoreInternal

class AuthorizationManager {
    private let auth = Auth.auth()
    private let provider = PhoneAuthProvider.provider()
    private var verificationID: String?
    private let keychain = KeyChainManager.shared
    private let userdefault = UserDefaults.standard
    
    /// Метод, для того чтобы отправлять номер телефона в Firebase
    /// - Parameters:
    ///   - phoneNumber: Номер теелфона
    ///   - completion: Получаем succes с verificationID
    func tryToSendSMSCode(phoneNumber: String, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            guard let verificationID = verificationID, error == nil else {
                completion(.failure(error!))
                return
            }
            
            self.userdefault.set(verificationID, forKey: Constants.Auth.verificationID)
            completion(.success(()))
        }
    }
    
    /// Метод для верификации смс кода
    /// - Parameters:
    ///   - smsCode: на телефоне
    ///   - completion: result
    func tryToSignIn(smsCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let verificationID = userdefault.string(forKey: Constants.Auth.verificationID) else {
            fatalError()
        }
        
        let credential = provider.credential(withVerificationID: verificationID, verificationCode: smsCode)
        
        auth.signIn(with: credential) { [weak self] result, error in
            guard let self = self else { return }
            guard let _ = result, error == nil else {
                completion(.failure(error!))
                return
            }
            
            if self.auth.currentUser != nil {
                self.saveSession()
                completion(.success(()))
            }
        }
    }
    
    private func saveSession() {
        let minuteLater = Calendar.current.date(byAdding: .era, value: 60, to: Date())!
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        let data = try! encoder.encode(minuteLater)
        self.keychain.save(data, service: Constants.Keychain.service, account: Constants.Keychain.account)
    }
}

