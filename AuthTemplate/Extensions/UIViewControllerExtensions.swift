//
//  UIViewControllerExtensions.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/27/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func displayAlert(title: String = "", message: String = "")
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
