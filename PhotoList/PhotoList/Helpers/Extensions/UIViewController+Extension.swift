//
//  UIViewController+Extension.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/29/22.
//

import UIKit

extension UIViewController {
    func showAlert(title: String = "",
                   message: String,
                   buttonText: String = "Ok",
                   style: UIAlertController.Style = .alert) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let action = UIAlertAction(title: buttonText, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }

    func hidesBackButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
