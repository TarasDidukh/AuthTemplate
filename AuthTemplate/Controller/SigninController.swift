//
//  SigninController.swift
//  AuthTemplate
//
//  Created by Taras Didukh on 10/26/18.
//  Copyright © 2018 Freeman. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa

class SigninController: UIViewController, UITextFieldDelegate {
    let PhoneMaxSymbols = 9
    let PasswordMinSymbols = 4
    var errorLabelHeight: CGFloat?
    @IBOutlet weak var viewPhoneContainer: UIView!
    @IBOutlet weak var fieldPhone: UITextField!
    @IBOutlet weak var fieldPassword: UITextField!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet var cnstrSocialsBottom: NSLayoutConstraint!
    @IBOutlet weak var cnstrErrorHeight: NSLayoutConstraint!
    
    public var profileService: ProfileServicing?
    public var authService: AuthServicing?
    
    var Signin: Action<(), User?, NetworkError>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        buttonSubmit.layer.cornerRadius = 5
        switchSubmit(isActive: false)
        fieldPassword.layer.cornerRadius = 5
        viewPhoneContainer.layer.cornerRadius = 5
        viewPhoneContainer.layer.masksToBounds = true
        fieldPassword.setLeftPaddingPoints(10)
        
        fieldPassword.attributedPlaceholder = NSAttributedString(string: "Пароль",
                           attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "Boulder")])
        fieldPhone.attributedPlaceholder = NSAttributedString(string: "Номер телефона",
                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor(named: "Boulder")])
        errorLabelHeight = cnstrErrorHeight.constant
        switchError(show: false)
        
        fieldPhone.delegate = self
        
        fieldPassword.reactive.continuousTextValues.combineLatest(with: fieldPhone.reactive.continuousTextValues).observeValues { passwordValue, phoneValue in
            self.switchError(show: false)
            self.switchSubmit(isActive:
                passwordValue?.count ?? 0 >= self.PasswordMinSymbols &&
                phoneValue?.count == self.PhoneMaxSymbols)
        }
        
        Signin = Action<(), User?, NetworkError>(execute: { _ in
            self.authService!.prepareSignIn()
            return self.profileService!.getMyProfile()
        })
        
        Signin?.isExecuting.signal.observeValues({ isExecute in
            self.buttonSubmit.loadingIndicator(isExecute)
            self.view.isUserInteractionEnabled = !isExecute;

        })
        
        Signin?.errors.signal.observeValues({ error in
            self.displayAlert(title: "", message: error.description)
        })
        
        Signin!.values.observe(on: UIScheduler()).take(first: 1).observeValues { user in
            self.performSegue(withIdentifier: "showProfile", sender: user)
            self.navigationController?.viewControllers.remove(at: 0)
        }
        
        buttonSubmit.reactive.controlEvents(.touchUpInside).observeValues { _ in
            self.fieldPhone.resignFirstResponder()
            self.fieldPassword.resignFirstResponder()
            self.singIn()
        }
        
    }

    func singIn() {
        if (validUser(phoneNumber: "+380\(fieldPhone.text ?? "")", password: fieldPassword.text ?? "")) {
            Signin!.apply().start()
        } else {
            switchError(show: true)
        }
    }
    
    func validUser(phoneNumber: String, password: String) -> Bool {
        return phoneNumber == "+380961235555" && password == "test"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == fieldPhone && textField.text?.count == PhoneMaxSymbols && !string.isEmpty {
            return false
        }
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let profileController = segue.destination as? ProfileController {
            profileController.user = sender as? User
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func switchError(show: Bool) {
        if labelError.isHidden == !show {
            return
        }
        if show {
            labelError.isHidden = false
            cnstrErrorHeight.constant = errorLabelHeight!
            cnstrSocialsBottom.isActive = false
        } else {
            labelError.isHidden = true
            cnstrErrorHeight.constant = 0
            cnstrSocialsBottom.isActive = true
        }
    }

    func switchSubmit(isActive: Bool) {
        if buttonSubmit.isEnabled == isActive {
            return
        }
        if isActive {
            buttonSubmit.layer.borderWidth = 0
            buttonSubmit.backgroundColor = UIColor(named: "PictonBlue")
            buttonSubmit.setTitleColor(UIColor.white, for: .normal)
            buttonSubmit.isEnabled = true
        } else {
            buttonSubmit.layer.borderWidth = 1
            buttonSubmit.isEnabled = false
            buttonSubmit.layer.borderColor = UIColor(named: "Boulder")?.cgColor
            buttonSubmit.setTitleColor(UIColor(named: "Boulder"), for: .normal)
            buttonSubmit.backgroundColor = UIColor(named: "MineShaft")
        }
    }
}
