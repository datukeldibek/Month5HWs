//
//  ViewController.swift
//  Month5HWs
//
//  Created by Jarae on 3/6/23.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet private weak var phoneNumberTetxtField: UITextField!
    
    private let authApi = AuthorizationManager()
    
    @IBAction private func sendTap() {
        guard let phone = phoneNumberTetxtField.text, !phone.isEmpty else { return }
        
        authApi.tryToSendSMSCode(phoneNumber: phone) { result in
            switch result {
            case .success:
                let vc = UIStoryboard(
                    name: "Main",
                    bundle: nil
                ).instantiateViewController(
                    withIdentifier: "SmsVerificationViewController"
                )
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            case .failure(let error):
                break
            }
        }
    }
}
