//
//  ViewController+Extension.swift
//  Month5HWs
//
//  Created by Jarae on 18/5/23.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Okat", style: .cancel))
        self.present(alert, animated: true)
    }
}
