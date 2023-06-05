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
        FirestoreManager.shared.saveTo(
            collection: .products,
            document: "",
            data: [
                "title" : titleTextField.text,
                "price" : priceTextField.text,
                "description" : descriptionTextField.text,
                "category" : categoryTextField.text,
                "brand" : brandTextField.text
            ]
        )
        clearTextFields()
        goToHomePage()
    }
    private func goToHomePage() {
        let vc = UIStoryboard(
            name: "Main",
            bundle: nil
        ).instantiateViewController(
            withIdentifier: "ProductsTabBarController"
        )
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    private func clearTextFields() {
        self.titleTextField.text = ""
        self.priceTextField.text = ""
        self.descriptionTextField.text = ""
        self.categoryTextField.text = ""
        self.brandTextField.text = ""
    }
}
