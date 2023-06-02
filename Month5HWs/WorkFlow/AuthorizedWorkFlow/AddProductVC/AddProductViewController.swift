//
//  AddProductViewController.swift
//  Month5HWs
//
//  Created by Jarae on 3/6/23.
//

import UIKit

class AddProductViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    
    @IBAction func addProductButton(_ sender: Any) {
        let product = [
            self.titleTextField.text ?? "",
            self.priceTextField.text ?? "",
            self.descriptionTextField.text ?? "",
            self.categoryTextField.text ?? "",
            self.brandTextField.text ?? ""
        ]
        FirestoreManager.shared.saveTo(collection: .news, document: "", data: ["Product" : product])
        
        clearTextFields()
    }
    private func clearTextFields() {
        self.titleTextField.text = ""
        self.priceTextField.text = ""
        self.descriptionTextField.text = ""
        self.categoryTextField.text = ""
        self.brandTextField.text = ""
    }
}
