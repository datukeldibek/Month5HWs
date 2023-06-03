//
//  SplashViewController.swift
//  Month5HWs
//
//  Created by Jarae on 2/6/23.
//
import UIKit

class SplashViewController: UIViewController {
    
    private let keychain = KeyChainManager.shared
    private let encoder = JSONDecoder()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        if let data = keychain.read(with: Constants.Keychain.service, Constants.Keychain.account),
           
            let date = try? decoder.decode(Date.self, from: data as! Data),
            date < Date() {
            handleAuthorizedFlow()
        } else {
            handleNotAuthorizedFlow()
        }
    }
    
    private func handleNotAuthorizedFlow() {
        let vc = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: "ViewController"
        )
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    private func handleAuthorizedFlow() {
        let vc = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: "ProductsTabBarController"
        )
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
}
