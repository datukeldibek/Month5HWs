//
//  SmsVerificationViewController.swift
//  Month5HWs
//
//  Created by Jarae on 3/6/23.
//

import UIKit

class SmsVerificationViewController: UIViewController {

    @IBOutlet private weak var verificationTetxtField: UITextField!
    
    private let authApi = AuthorizationManager()
    
    @IBAction private func sendVerificationCodeTap() {
        guard let vCode = verificationTetxtField.text, !vCode.isEmpty else {
            return
        }
        authApi.tryToSignIn(smsCode: vCode) { result in
            if case .success = result {
                let vc = UIStoryboard(
                    name: "Main",
                    bundle: nil
                ).instantiateViewController(
                    withIdentifier: "ProductsTabBarController"
                )
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false)
            } else {
                self.showAlert(with: "", message: "")
            }
        }
    }
}
