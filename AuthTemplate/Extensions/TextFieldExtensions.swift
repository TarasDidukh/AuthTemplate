//
//  TextFieldExtensions.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/26/18.
//  Copyright © 2018 Freeman. All rights reserved.
//
import UIKit
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
